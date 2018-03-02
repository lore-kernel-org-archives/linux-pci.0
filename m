Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v15 8/9] HISI LPC: Add ACPI support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
 <1519663249-9850-9-git-send-email-john.garry@huawei.com>
 <1519933855.10722.364.camel@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <10d3b5b8-0662-27b1-ff72-5080dd54d78e@huawei.com>
Date: Fri, 2 Mar 2018 10:19:05 +0000
MIME-Version: 1.0
In-Reply-To: <1519933855.10722.364.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/03/2018 19:50, Andy Shevchenko wrote:
> On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:
>> Based on the previous patches, this patch supports the
>> LPC host on hip06/hip07 for ACPI FW.
>>
>> It is the responsibility of the LPC host driver to
>> enumerate the child devices, as the ACPI scan code will
>> not enumerate children of "indirect IO" hosts.
>>
>> The ACPI table for the LPC host controller and the child
>> devices is in the following format:
>>   Device (LPC0) {
>>     Name (_HID, "HISI0191")  // HiSi LPC
>>     Name (_CRS, ResourceTemplate () {
>>       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>>     })
>>   }
>>
>>   Device (LPC0.IPMI) {
>>     Name (_HID, "IPI0001")
>>     Name (LORS, ResourceTemplate() {
>>       QWordIO (
>>         ResourceConsumer,
>> 	MinNotFixed,     // _MIF
>> 	MaxNotFixed,     // _MAF
>> 	PosDecode,
>> 	EntireRange,
>> 	0x0,             // _GRA
>> 	0xe4,            // _MIN
>> 	0x3fff,          // _MAX
>> 	0x0,             // _TRA
>> 	0x04,            // _LEN
>> 	, ,
>> 	BTIO
>>       )
>>     })
>>
>> Since the IO resources of the child devices need to be
>> translated from LPC bus addresses to logical PIO addresses,
>> and we shouldn't modify the resources of the devices
>> generated in the FW scan, a per-child MFD is created as
>> a substitute. The MFD IO resources will be the translated
>> bus addresses of the ACPI child.
>

Hi Andy,

> Ok, this needs to be thought about a bit more.
>
> I guess I understand what's is the problem with PNP IDs in the driver.
>
> You probe your LPC device quite late.
> One option is to move from classical probe to a event-driven model, i.e.
> via registering a notifier (see acpi_lpss.c), preparing necessary stuff
> at earlier stages and then register devices by their enumeration and
> appearance.
>
> Though, if I would be you I would seek a opinion from Rafael and Mika
> (maybe others as well).

I would like to give a bit more background on this HW. This HW is now 
for us a legacy device. It will be used in no more chipsets. It is only 
used in hip06 and hip07 chipsets on our D03 and D05 boards, 
respectively. On these boards we have the following LPC slave devices only:
D03: UART, IPMI
D05: IPMI

Supporting IPMI for D05 is required. Supporting legacy D03 and the UART 
is a "nice-to-have". But it is definitely ok for us to not support this 
device.

Our previous ACPI support solution did use a scan handler for this host, 
but there was some sensible pushback on this - please check this if not 
familiar: https://lkml.org/lkml/2018/2/14/532

Overall it does not make sense to try to move this back to drivers/acpi 
and receive more pushback from that direction, and only delay 
indefinitely upstreaming this driver (which is now running at ~27 months 
since v1) to just support a PNP-compatible device which we don't care 
too much about.

>
> See also some comments below.
>
>> +#ifdef CONFIG_ACPI
>> +#define MFD_CHILD_NAME_PREFIX DRV_NAME"-"
>
>> +#define MFD_CHILD_NAME_LEN (ACPI_ID_LEN +
>> sizeof(MFD_CHILD_NAME_PREFIX))
>
> ..._PREFIX) - 1)

I didn't think so. But now I have noticed that ACPI_ID_LEN is 9 (which 
of course it needs to be for pnpid name), and not 8. I was thinking that 
the sizeof(MFD_CHILD_NAME_PREFIX) was providing the extra byte for the 
NULL terminator I required.

>
> ?
>
>> +static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
>> +				     struct acpi_device *host,
>> +				     struct resource *res)
>> +{
>> +	unsigned long sys_port;
>
>> +	resource_size_t len = res->end - res->start;
>
> resource_size()

should be ok

>
>> +	return 0;
>> +}
>
>
>> +static int hisi_lpc_acpi_set_io_res(struct device *child,
>> +				    struct device *hostdev,
>> +				    const struct resource **res,
>> +				    int *num_res)
>> +{
>
>> +	/*
>> +	 * The following code segment to retrieve the resources is
>> common to
>> +	 * acpi_create_platform_device(), so consider a common helper
>> function
>> +	 * in future.
>> +	 */
>> +	count = acpi_dev_get_resources(adev, &resource_list, NULL,
>> NULL);
>> +	if (count <= 0) {
>> +		dev_dbg(child, "failed to get resources\n");
>
>> +		return count ? count : -EIO;
>
> count == 0 --> return 0;
>

The idea is that having no IO resources is a failure for a slave device 
on this bus. So then, if count == 0, we should error.

> Is it by design? (I didn't check acpi_create_platform_device() though)
>
>> +	}
>> +
>> +	resources = devm_kcalloc(hostdev, count, sizeof(*resources),
>> +				 GFP_KERNEL);
>> +	if (!resources) {
>> +		dev_warn(hostdev, "could not allocate memory for %d
>> resources\n",
>> +			 count);
>> +		acpi_dev_free_resource_list(&resource_list);
>> +		return -ENOMEM;
>> +	}
>> +	count = 0;
>> +	list_for_each_entry(rentry, &resource_list, node)
>> +		resources[count++] = *rentry->res;
>> +
>> +	acpi_dev_free_resource_list(&resource_list);
>
>> +
>> +	return 0;
>> +}
>
>> +
>> +/*
>> + * hisi_lpc_acpi_probe - probe children for ACPI FW
>> + * @hostdev: LPC host device pointer
>> + *
>> + * Returns 0 when successful, and a negative value for failure.
>> + *
>> + * Scan all child devices and create a per-device MFD with
>> + * logical PIO translated IO resources.
>> + */
>> +static int hisi_lpc_acpi_probe(struct device *hostdev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(hostdev);
>> +	struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
>> +	struct mfd_cell *mfd_cells;
>> +	struct acpi_device *child;
>> +	int size, ret, count = 0, cell_num = 0;
>> +
>> +	list_for_each_entry(child, &adev->children, node)
>> +		cell_num++;
>> +
>> +	/* allocate the mfd cell and companion acpi info, one per
>> child */
>> +	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
>> +	mfd_cells = devm_kcalloc(hostdev, cell_num, size,
>> GFP_KERNEL);
>> +	if (!mfd_cells)
>> +		return -ENOMEM;
>> +
>
>> +	hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)
>> +					&mfd_cells[cell_num];
>
> One line, please.

Should be possible. I just want to keep checkpatch happy.

>
> Just noticed that calloc() memory layout is not the same how you are
> using it.

Right, because we need to group the MFD cells together.

>
>> +	/* Only consider the children of the host */
>> +	list_for_each_entry(child, &adev->children, node) {
>> +		struct mfd_cell *mfd_cell = &mfd_cells[count];
>> +		struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cell =
>> +					&hisi_lpc_mfd_cells[count];
>> +		struct mfd_cell_acpi_match *acpi_match =
>> +					&hisi_lpc_mfd_cell-
>>> acpi_match;
>> +		char *name = hisi_lpc_mfd_cell[count].name;
>> +		char *pnpid = hisi_lpc_mfd_cell[count].pnpid;
>> +		struct mfd_cell_acpi_match match = {
>> +			.pnpid = pnpid,
>> +		};
>> +
>
>> +		snprintf(name, MFD_CHILD_NAME_LEN,
>> MFD_CHILD_NAME_PREFIX"%s",
>> +			 acpi_device_hid(child));
>
> No possibility of identical devices?

As explained above, actually no in reality. So I should comment on this.

>
>> +		snprintf(pnpid, ACPI_ID_LEN, "%s",
>> acpi_device_hid(child));
>> +
>> +		memcpy(acpi_match, &match, sizeof(*acpi_match));
>> +		mfd_cell->name = name;
>> +		mfd_cell->acpi_match = acpi_match;
>> +
>> +		ret = hisi_lpc_acpi_set_io_rsses(&child->dev, &adev-
>>> dev,
>> +					       &mfd_cell->resources,
>> +					       &mfd_cell-
>>> num_resources);
>> +		if (ret) {
>> +			dev_warn(&child->dev, "set resource
>> fail(%d)\n", ret);
>> +			return ret;
>> +		}
>> +		count++;
>> +	}
>> +
>> +	ret = mfd_add_devices(hostdev,
>
>> PLATFORM_DEVID_NONE,
>
> You mean it's not possible to have more than one identical device?

Again, as above, this would not happen. I could make the code more 
generic, but I feel that there is little gain.

>
>> +			      mfd_cells, cell_num, NULL, 0, NULL);
>> +	if (ret) {
>> +		dev_err(hostdev, "failed to add mfd cells (%d)\n",
>> ret);
>> +		return ret;
>> +	}
>

Thanks,
John

>



Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E6C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361E221741
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDJWNc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:13:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:53146 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfDJWNb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 18:13:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 15:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="335654041"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2019 15:13:24 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 65A83580310;
        Wed, 10 Apr 2019 15:13:24 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 2/2] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4818f4dfa41bddc3968da4717c453897d4ad5717.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190410184124.GF256045@google.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <dc4e2bcf-44c9-1ffb-ab4f-75c04340b8dd@linux.intel.com>
Date:   Wed, 10 Apr 2019 15:12:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410184124.GF256045@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi ,

On 4/10/19 11:41 AM, Bjorn Helgaas wrote:
> On Tue, Mar 19, 2019 at 01:47:29PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification v3.2 ECN
>> (https://members.pcisig.com/wg/PCI-SIG/document/12614), when firmware
>> owns Downstream Port Containment (DPC), its expected to use the "Error
>> Disconnect Recover" (EDR) notification to alert OSPM of a DPC event and
>> if OS supports EDR, its expected to handle the software state invalidation
>> and port recovery in OS and let firmware know the recovery status via _OST
>> ACPI call.
>>
>> Since EDR is a hybrid service, DPC service shall be enabled in OS even
>> if AER is not natively enabled in OS.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/Kconfig        |  10 +
>>   drivers/pci/pcie/dpc.c          | 326 ++++++++++++++++++++++++++++++--
Thanks for the review comments.
> I'll be looking for Keith's reviewed-by for this eventually.
>
> It looks like this could be split into some smaller patches:
>
>    - Add dpc_dev.native_dpc (hopefully we can find a less confusing name)
>    - Convert dpc_handler() to dpc_handler() + dpc_process_error()
>    - Add EDR support
Ok. I will split them in next patch set.
>
>>   drivers/pci/pcie/portdrv_core.c |   9 +-
>>   3 files changed, 329 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index 5cbdbca904ac..55f65d1cbc9e 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -142,3 +142,13 @@ config PCIE_PTM
>>   
>>   	  This is only useful if you have devices that support PTM, but it
>>   	  is safe to enable even if you don't.
>> +
>> +config PCIE_EDR
>> +	bool "PCI Express Error Disconnect Recover support"
>> +	default n
>> +	depends on PCIE_DPC && ACPI
>> +	help
>> +	  This options adds Error Disconnect Recover support as specified
>> +	  in PCI firmware specification v3.2 Downstream Port Containment
>> +	  Related Enhancements ECN. Enable this if you want to support hybrid
>> +	  DPC model which uses both firmware and OS to implement DPC.
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 7b77754a82de..bdf4ca8a0acb 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/init.h>
>>   #include <linux/pci.h>
>> +#include <linux/acpi.h>
>>   
>>   #include "portdrv.h"
>>   #include "../pci.h"
>> @@ -20,8 +21,23 @@ struct dpc_dev {
>>   	u16			cap_pos;
>>   	bool			rp_extensions;
>>   	u8			rp_log_size;
>> +	bool			native_dpc;
> This is going to be way too confusing with a "native_dpc" in both the
> struct pci_host_bridge and the struct dpc_dev.
Any suggestions? what about native_mode ?
>
>> +	pci_ers_result_t	error_state;
>> +#ifdef CONFIG_ACPI
>> +	struct acpi_device	*adev;
>> +#endif
>>   };
>>   
>> +#ifdef CONFIG_ACPI
>> +
>> +#define EDR_PORT_ENABLE_DSM     0x0C
>> +#define EDR_PORT_LOCATE_DSM     0x0D
>> +
>> +static const guid_t pci_acpi_dsm_guid =
>> +		GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
>> +			  0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
>> +#endif
>> +
>>   static const char * const rp_pio_error_string[] = {
>>   	"Configuration Request received UR Completion",	 /* Bit Position 0  */
>>   	"Configuration Request received CA Completion",	 /* Bit Position 1  */
>> @@ -67,6 +83,9 @@ void pci_save_dpc_state(struct pci_dev *dev)
>>   	if (!dpc)
>>   		return;
>>   
>> +	if (!dpc->native_dpc)
>> +		return;
>> +
>>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>>   	if (!save_state)
>>   		return;
>> @@ -88,6 +107,9 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>>   	if (!dpc)
>>   		return;
>>   
>> +	if (!dpc->native_dpc)
>> +		return;
>> +
>>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>>   	if (!save_state)
>>   		return;
>> @@ -224,10 +246,9 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>   	return 1;
>>   }
>>   
>> -static irqreturn_t dpc_handler(int irq, void *context)
>> +static void dpc_process_error(struct dpc_dev *dpc)
>>   {
>>   	struct aer_err_info info;
>> -	struct dpc_dev *dpc = context;
>>   	struct pci_dev *pdev = dpc->dev->port;
>>   	struct device *dev = &dpc->dev->device;
>>   	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
>> @@ -261,6 +282,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
>>   
>>   	/* We configure DPC so it only triggers on ERR_FATAL */
>>   	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
>> +}
>> +
>> +static irqreturn_t dpc_handler(int irq, void *context)
>> +{
>> +	struct dpc_dev *dpc = context;
>> +
>> +	dpc_process_error(dpc);
>>   
>>   	return IRQ_HANDLED;
>>   }
>> @@ -283,6 +311,230 @@ static irqreturn_t dpc_irq(int irq, void *context)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +void dpc_error_resume(struct pci_dev *dev)
> Looks like this should be static?
yes. I will fix it in next version.
>
>> +{
>> +	struct dpc_dev *dpc;
>> +
>> +	dpc = to_dpc_dev(dev);
>> +	if (!dpc)
>> +		return;
> I don't think it's possible for dpc to be NULL, is it?  Remove the
> test if not.
ok.
>
>> +	dpc->error_state = PCI_ERS_RESULT_RECOVERED;
>> +}
>> +
>> +#ifdef CONFIG_ACPI
>> +
>> +/*
>> + * _DSM wrapper function to enable/disable DPC port.
>> + * @dpc   : DPC device structure
>> + * @enable: status of DPC port (0 or 1).
>> + *
>> + * returns 0 on success or errno on failure.
>> + */
>> +static int acpi_enable_dpc_port(struct dpc_dev *dpc, bool enable)
>> +{
>> +	union acpi_object *obj;
>> +	int status;
>> +	union acpi_object argv4;
>> +
>> +	/* Check whether EDR_PORT_ENABLE_DSM is supported in firmware */
>> +	status = acpi_check_dsm(dpc->adev->handle, &pci_acpi_dsm_guid, 1,
>> +				1 << EDR_PORT_ENABLE_DSM);
> I don't think this acpi_check_dsm() is necessary, is it?  I expect
> acpi_evaluate_dsm() to fail nicely if there's no _DSM or it doesn't
> support the function.
will remove it next version.
>
>> +	if (!status)
>> +		return -ENOTSUPP;
>> +
>> +	argv4.type = ACPI_TYPE_INTEGER;
>> +	argv4.integer.value = enable;
>> +
>> +	obj = acpi_evaluate_dsm(dpc->adev->handle, &pci_acpi_dsm_guid, 1,
>> +				EDR_PORT_ENABLE_DSM, &argv4);
>> +	if (!obj)
>> +		return -EIO;
>> +
>> +	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == enable)
>> +		status = 0;
>> +	else
>> +		status = -EIO;
>> +
>> +	ACPI_FREE(obj);
>> +
>> +	return status;
>> +}
>> +
>> +/*
>> + * _DSM wrapper function to locate DPC port.
>> + * @dpc   : DPC device structure
>> + *
>> + * returns pci_dev or NULL.
>> + */
>> +static struct pci_dev *acpi_locate_dpc_port(struct dpc_dev *dpc)
>> +{
>> +	union acpi_object *obj;
>> +	int status;
>> +	u16 port;
>> +
>> +	/* Check whether EDR_PORT_LOCATE_DSM is supported in firmware */
>> +	status = acpi_check_dsm(dpc->adev->handle, &pci_acpi_dsm_guid, 1,
>> +				1 << EDR_PORT_LOCATE_DSM);
> Unnecessary?
Agreed
>
>> +	if (!status)
>> +		return dpc->dev->port;
> If you *do* need the acpi_check_dsm(), I would have expected to return
> NULL in this error case?
>
>> +
>> +
> Extra blank line here.
>
>> +	obj = acpi_evaluate_dsm(dpc->adev->handle, &pci_acpi_dsm_guid, 1,
>> +				EDR_PORT_LOCATE_DSM, NULL);
>> +	if (!obj)
>> +		return NULL;
>> +
>> +	if (obj->type == ACPI_TYPE_INTEGER) {
>> +		/*
>> +		 * Firmware returns DPC port BDF details in following format:
>> +		 *	15:8 = bus
>> +		 *	7:3 = device
>> +		 *	2:0 = function
>> +		 */
>> +		port = obj->integer.value;
>> +		ACPI_FREE(obj);
>> +	} else {
>> +		ACPI_FREE(obj);
>> +		return NULL;
>> +	}
>> +
>> +	return pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(port), port & 0xff);
>> +}
>> +
>> +/*
>> + * _OST wrapper function to let firmware know the status of EDR event.
>> + * @dpc   : DPC device structure.
>> + * @status: Status of EDR event.
>> + *
> Spurious blank line in the comment.
>
>> + */
>> +static int acpi_send_edr_status(struct dpc_dev *dpc,  u16 status)
>> +{
>> +	u32 ost_status;
>> +	struct pci_dev *pdev = dpc->dev->port;
>> +
>> +	dev_dbg(&pdev->dev, "Sending EDR status :%x\n", status);
>> +
>> +	ost_status =  PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +	ost_status = (ost_status << 16) | status;
>> +
>> +	if (!acpi_has_method(dpc->adev->handle, "_OST"))
>> +		return -ENOTSUPP;
> This acpi_has_method() check is superfluous, isn't it?  I would expect
> acpi_evaluate_ost() to fail gracefully if there's no _OST.
>
> I do see several other instances of code of the form:
>
>    if (!acpi_has_method(handle, "XXXX"))
>      return false;
>
>    status = acpi_evaluate_*(handle, "XXXX", ...);
>
> But I think that's a pointless pattern.  I think we could just try to
> evaluate the method directly, since the evaluation will fail if the
> method doesn't exist:
>
>    status = acpi_evaluate_*(handle, "XXXX", ...);
Agreed.
>
>> +	status = acpi_evaluate_ost(dpc->adev->handle,
>> +				   ACPI_NOTIFY_DISCONNECT_RECOVER,
>> +				   ost_status, NULL);
>> +	if (ACPI_FAILURE(status))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Helper function used for disconnecting the child devices when EDR event is
>> + * received from firmware.
>> + */
>> +static void dpc_disconnect_devices(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *udev;
>> +	struct pci_bus *parent;
>> +	struct pci_dev *pdev, *temp;
>> +
>> +	dev_dbg(&dev->dev, "Disconnecting the child devices\n");
>> +
>> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>> +		udev = dev;
>> +	else
>> +		udev = dev->bus->self;
>> +
>> +	parent = udev->subordinate;
>> +	pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
>> +
>> +	pci_lock_rescan_remove();
>> +	pci_dev_get(dev);
>> +	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>> +					 bus_list) {
>> +		pci_stop_and_remove_bus_device(pdev);
>> +	}
>> +	pci_dev_put(dev);
>> +	pci_unlock_rescan_remove();
>> +}
>> +
>> +static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>> +{
>> +	struct dpc_dev *dpc = (struct dpc_dev *) data;
>> +	struct pci_dev *pdev;
>> +	u16 status, cap;
>> +
>> +	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
>> +		return;
>> +
>> +	if (!data) {
>> +		pr_err("Invalid EDR event\n");
> In what instance can "data" be NULL?  I think *never*, unless ACPI
> screwed up and lost the context you supplied to
> acpi_install_notify_handler().  In that case, we should do something
> more significant than print a message and just return.  I think we
> should just omit this test, and if ACPI screwed up, we'll take a null
> pointer dereference oops, we'll see exactly where, and we'll have a
> chance to fix the problem.
Makes sense. I will fix it in next version.
>
>> +		return;
>> +	}
>> +
>> +	dev_dbg(&dpc->dev->port->dev, "Valid EDR event received\n");
> Set "pdev" at declaration and use it in these printks.
>
>> +
>> +	/*
>> +	 * Check if _DSM(0xD) is available, and if present locate the
>> +	 * port which issued EDR event.
>> +	 */
>> +	pdev = acpi_locate_dpc_port(dpc);
> Can this be done at probe-time instead of event-time?
>
>> +	if (!pdev) {
>> +		dev_err(&dpc->dev->port->dev, "No valid port found\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Get DPC priv data for given pdev
>> +	 */
>> +	dpc = to_dpc_dev(pdev);
>> +	dpc->error_state = PCI_ERS_RESULT_DISCONNECT;
>> +	pdev = dpc->dev->port;
> It's quite confusing to reassign pdev here.  The comment about "Get
> DPC priv data for given pdev" is really superfluous since that much is
> obvious from the code.  What's *not* obvious is whether this "pdev =
> dpc->dev->port" changes anything and if so, why.
No its not required. It does not add any value. I will remove it in next 
version.
>
>> +	cap = dpc->cap_pos;
>> +
>> +	/*
>> +	 * Check if the port supports DPC:
>> +	 *
>> +	 * if port does not support DPC, then let firmware handle
>> +	 * the error recovery and OS is responsible for cleaning
>> +	 * up the child devices.
>> +	 *
>> +	 * if port supports DPC, then fall back to default error
>> +	 * recovery.
> Capitalize first letter of sentences.
ok
>
>> +	 *
>> +	 */
>> +	if (cap) {
>> +		/* Check if there is a valid DPC trigger */
>> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>> +		if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
>> +			dev_err(&pdev->dev, "Invalid DPC trigger\n");
> Include "status" value in the printk.
ok
>
>> +			return;
>> +		}
>> +		dpc_process_error(dpc);
>> +	}
>> +
>> +	if (dpc->error_state == PCI_ERS_RESULT_RECOVERED) {
>> +		/*
>> +		 * Recovery is successful, so send
>> +		 * _OST(0xF, BDF << 16 | 0x80, "") to firmware.
>> +		 */
>> +		status = 0x80;
>> +	} else {
>> +		/*
>> +		 * Recovery is not successful, so disconnect child devices
>> +		 * and send _OST(0xF, BDF << 16 | 0x81, "") to firmware.
>> +		 */
>> +		dpc_disconnect_devices(pdev);
>> +		status = 0x81;
>> +	}
>> +
>> +	acpi_send_edr_status(dpc, status);
>> +}
>> +
>> +#endif
>> +
>>   #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>>   static int dpc_probe(struct pcie_device *dev)
>>   {
>> @@ -291,9 +543,10 @@ static int dpc_probe(struct pcie_device *dev)
>>   	struct device *device = &dev->device;
>>   	int status;
>>   	u16 ctl, cap;
>> -
>> -	if (pcie_aer_get_firmware_first(pdev))
>> -		return -ENOTSUPP;
>> +#ifdef CONFIG_ACPI
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	acpi_status astatus;
>> +#endif
>>   
>>   	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
>>   	if (!dpc)
>> @@ -302,16 +555,53 @@ static int dpc_probe(struct pcie_device *dev)
>>   	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>>   	dpc->dev = dev;
>>   	set_service_data(dev, dpc);
>> +	dpc->error_state = PCI_ERS_RESULT_NONE;
>> +
>> +	if (!pcie_aer_get_firmware_first(pdev))
>> +		if (pci_aer_available() && dpc->cap_pos)
>> +			dpc->native_dpc = 1;
>>   
>> -	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>> -					   dpc_handler, IRQF_SHARED,
>> -					   "pcie-dpc", dpc);
>> -	if (status) {
>> -		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
>> -			 status);
>> -		return status;
>> +	/*
>> +	 * If native support is not enabled and ACPI is not
>> +	 * enabled then return error.
>> +	 */
>> +	if (!dpc->native_dpc && !IS_ENABLED(CONFIG_APCI))
>> +		return -ENODEV;
>> +
>> +	if (dpc->native_dpc) {
>> +		status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>> +						   dpc_handler, IRQF_SHARED,
>> +						   "pcie-dpc", dpc);
>> +		if (status) {
>> +			dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
>> +				 status);
>> +			return status;
>> +		}
>>   	}
>>   
>> +#ifdef CONFIG_ACPI
>> +	if (!dpc->native_dpc) {
>> +		if (!adev) {
>> +			dev_err(device, "No valid acpi device found\n");
> s/acpi/ACPI/ (in comments, printk, other English text)
ok
>
>> +			return -ENODEV;
>> +		}
>> +
>> +		dpc->adev = adev;
>> +
>> +		/* Register ACPI notifier for EDR event */
> "Register handler for System events, one of which is the EDR event"?
In our case, we only handle EDR event. So I just explicitly mentioned it.
>
>> +		astatus = acpi_install_notify_handler(adev->handle,
>> +						      ACPI_SYSTEM_NOTIFY,
>> +						      edr_handle_event,
>> +						      dpc);
>> +
>> +		if (ACPI_FAILURE(astatus)) {
>> +			dev_err(device, "Install notifier failed\n");
> Mention "ACPI notify handler" here.
ok
>
>> +			return -EBUSY;
>> +		}
>> +
>> +		acpi_enable_dpc_port(dpc, true);
>> +	}
>> +#endif
>>   	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
>>   	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
>>   
>> @@ -325,8 +615,12 @@ static int dpc_probe(struct pcie_device *dev)
>>   		}
>>   	}
>>   
>> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>> -	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>> +	if (dpc->native_dpc) {
>> +		ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL |
>> +			PCI_EXP_DPC_CTL_INT_EN;
>> +		pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
>> +				      ctl);
>> +	}
>>   
>>   	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
>>   		cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
>> @@ -344,6 +638,9 @@ static void dpc_remove(struct pcie_device *dev)
>>   	struct pci_dev *pdev = dev->port;
>>   	u16 ctl;
>>   
>> +	if (!dpc->native_dpc)
>> +		return;
>> +
>>   	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
>>   	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
>>   	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>> @@ -356,6 +653,7 @@ static struct pcie_port_service_driver dpcdriver = {
>>   	.probe		= dpc_probe,
>>   	.remove		= dpc_remove,
>>   	.reset_link	= dpc_reset_link,
>> +	.error_resume   = dpc_error_resume,
>>   };
>>   
>>   int __init pcie_dpc_init(void)
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 865f12f4b314..050cbb7a5083 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -249,9 +249,14 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   		pcie_pme_interrupt_enable(dev, false);
>>   	}
>>   
>> +	/*
>> +	 * If EDR support is enabled in OS, then even if AER is not handled in
>> +	 * OS, DPC service can be enabled.
>> +	 */
>>   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> -	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
>> -	    (pcie_ports_native || host->native_dpc))
>> +	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
>> +	    (pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
>> +	    (pcie_ports_native || host->native_dpc))))
> Holy cow, I think I'll have to schedule an hour sometime to figure
> out what's going on here :)
Please check the previous patch in this series for details related to 
host->native_dpc.

host->native_dpc is set/unset based on _OSC negotiation in 
drivers/acpi/pci_root.c

Previously if BIOS handles AER and DPC then we don't need to enable 
AER/DPC services in OS. But with EDR support (hybrid mode), even if BIOS 
handles DPC support, there is way for it let OS handle the port recovery 
and error handling. So we should enable the DPC service independently. 
That's why I have added additional if condition for non-native DPC mode 
with EDR support enabled.

If we expand the if condition it would look like,

if (port has dpc capability) {

     if (EDR support is supported/enabled in OS and bios_handles_dpc) then
         services |= PCIE_PORT_SERVICE_DPC;

         if ( AER/DPC is handled in OS)
         services |= PCIE_PORT_SERVICE_DPC;

}

>
>>   		services |= PCIE_PORT_SERVICE_DPC;
>>   
>>   	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM || -- 2.20.1
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


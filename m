Return-Path: <jonathan.yong@intel.com>
Return-Path: <jonathan.yong@intel.com>
Message-ID: <57315B15.5030709@intel.com>
Date: Tue, 10 May 2016 11:52:53 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com> <1461047358-4736-2-git-send-email-jonathan.yong@intel.com> <20160429162026.GC949@localhost>
In-Reply-To: <20160429162026.GC949@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 04/30/2016 00:20, Bjorn Helgaas wrote:

>> +	return sprintf(buf, "%u\n", word & PCI_PTM_CTRL_ENABLE ? 1 : 0);
>> +}
>> +
>> +static ssize_t ptm_status_store(struct device *dev,
>> +	struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	unsigned long val;
>> +	ssize_t ret;
>> +
>> +	ret = kstrtoul(buf, 0, &val);
>> +	if (ret)
>> +		return ret;
>> +	if (val)
>> +		return pci_enable_ptm(pdev);
>> +	pci_disable_ptm(pdev);
>> +	return 0;
>> +}
>> +
>> +static DEVICE_ATTR_RW(ptm_status);
>> +
>> +void pcie_ptm_remove_sysfs_dev_files(struct pci_dev *dev)
>> +{
>> +	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
>> +		return;
>> +	device_remove_file(&dev->dev, &dev_attr_ptm_status);
>> +}
>
> This is called in the device remove path.  Obviously we want to
> remove the sysfs file.  But we currently don't do anything to the PTM
> capability itself.
>
> What happens if the device has PTM enabled, we hotplug remove it
> (using the sysfs interface so the device stays physically present and
> powered up), manually disable PTM on the upstream switch, then hotplug
> add the device back?  If the switch has PTM disabled but the device
> has PTM enabled, that sounds like an illegal configuration.
>
> Is this scenario possible?  Maybe the hotplug remove would power off
> the device?  I guess the current pci_ptm_init() path actually would
> disable PTM on the new device because it's disabled on the upstream
> switch.
>
> But since PTM is autonomous once enabled, I would assume the new
> device (with PTM enabled) could send PTM messages upstream, and it
> sounds (per sec 6.22.3) like those would be treated as Unsupported
> Requests, which means we'd report errors.
>
> I think we might want to disable PTM before we remove a device.
>

I'm not familiar with PCI hotplug, release_slot in acpiphp_core.c?

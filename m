Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E306403AEC;
	Wed, 22 Jul 2026 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758753; cv=none; b=oLhM6fjvrSXSUsJ+n9YEupiaGjCZtfDSFeapvOCad05f9kx+HnLTsdbam8pyvFdIFO7VoYOidW8xaCJKkYe/2b+iz6fAq16Hjv7alrz21ksoqfOH1bvCbXYzOg3j/HN6PIxI851SwLTDOC+S96iuzvbmFC4HRuZbfzCVizaMq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758753; c=relaxed/simple;
	bh=XQ7u1MyKKlGmF2bPW1TJXmRtzSszTdoR46RLPJa4ujs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RoJg6esPxEClp5vs3nnsczB860uPGc8dpRmBKRRiKYc2AcfUaC4Xw0NLbKfqe+hTL45hVE0IvenOO/jLH6K0lBmR59cGpPmLJS34ukE25LsxYf1kBBZrrv3bncMmOYbyrC593e8sCR0+5lKFVlmLXFOwWwtxB0K1l15XA3WL8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+A5g705; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+A5g705"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254E41F00A3A;
	Wed, 22 Jul 2026 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758752;
	bh=uF1Rk5hdqDCZT4L7jue770UXkDWWiIj6LF2BqLCa1hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=D+A5g705/alUW5pjWD4+a4F6XEXuoDNqR2WsHkyOcLI6TN79lzq+KZ8C6EEpV3D+y
	 lfle1IAUowfNXyjFXHYP0Qb2XzfIsxlDXrB0/qZrBqEufLVA0e5lH/YGrmjKOtDoKU
	 Dy9xLynQBBJ5CwWOu6iHJzSEb0PcVmNSHcB5qlw39oy8utMF1iAaQ9bfla3b5OyQv9
	 zHEFQeW4Y/fUY43iiXg1dxs6sHjMxV7nmq2i3xpYlC7LClV67dafKj27JNHz/aK5Za
	 Xn929VxJyCoQubcNo+/tWLYPOVx6iw6VTHwiq7KqopNkalVw3icz1vLPs/kWNTVSSz
	 sa6WibRRB25aw==
Date: Wed, 22 Jul 2026 17:19:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	bhelgaas@google.com, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, kiran.k@intel.com,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for
 PLDR
Message-ID: <20260722221910.GA753179@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>

[+cc Alex, linux-pci]

On Wed, Jul 22, 2026 at 06:51:57AM +0530, Chandrashekar Devegowda wrote:
> Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_rst
> to allow userspace to trigger PLDR (Product Level Device Reset).

IMO there's no need to abbreviate "reset" as "rst".  I'd rather spell
it out as "vendor_reset".

Several other drivers that add files in /sys/bus/pci/devices/ have
documentation in Documentation/ABI/testing/sysfs-bus-pci-drivers-*.

It seems important to mention the fact that IIUC, this PLDR will
release any driver attached to the wifi device that shares hardware
with this bluetooth device, do the reset, and reprobe the wifi.

I guess this can't be integrated into the generic pci_reset_function()
reachable via the sysfs 'reset' attribute because of the fact that it
affects both the BT and the wifi device, which are different PCI
functions.  But I cc'd Alex anyway since he's the real guru on resets.

FWIW, I learned a lot about the idiosyncrasies of these connected BT
and wifi devices in this old conversation:
https://lore.kernel.org/all/20250314101613.3682010-1-chandrashekar.devegowda@intel.com

> Reading the attribute displays supported reset types. Writing
> integer 0 triggers PLDR. Any other input is rejected with
> -EINVAL and a warning log.
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> ---
> Changes in v4:
>   - Rebased on latest bluetooth-next (6f55ad8fb0ac) to fix
>     CI apply failure

v4: https://lore.kernel.org/all/20260722012158.813793-1-chandrashekar.devegowda@intel.com/

> Changes in v3:
>   - Dropped reset_type parameter approach from hdev->reset()
>   - Directly call btintel_pcie_request_reset() instead of manual
>     flag manipulation and schedule_work()
>   - Accept only integer 0 for PLDR trigger
>   - Handle schedule_work() failure: release pci_dev_get refcount
>     and clear RECOVERY_IN_PROGRESS flag
>   - Fix remove ordering: device_remove_file before disable_work_sync

v3: https://lore.kernel.org/all/20260722001434.804931-1-chandrashekar.devegowda@intel.com/

> Changes in v2:
>   - Added reset_type parameter to hdev->reset() callback (1/2)
>   - vendor_rst sysfs used reset_type to select PLDR (2/2)

v2: https://lore.kernel.org/all/20260618085016.9173-1-chandrashekar.devegowda@intel.com/

> Changes in v1:
>   - Initial vendor_rst PCI sysfs implementation
>  drivers/bluetooth/btintel_pcie.c | 42 +++++++++++++++++++++++++++++++-

v1: https://lore.kernel.org/all/20260612012832.2395034-1-chandrashekar.devegowda@intel.com/

>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 2e28847263ab..a412ca7ff3ad 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2781,7 +2781,10 @@ static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
>  	data->reset_type = type;
>  
>  	pci_dev_get(data->pdev);
> -	schedule_work(&data->reset_work);
> +	if (!schedule_work(&data->reset_work)) {
> +		pci_dev_put(data->pdev);
> +		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
> +	}
>  }
>  
>  static void btintel_pcie_hci_reset(struct hci_dev *hdev)
> @@ -2791,6 +2794,36 @@ static void btintel_pcie_hci_reset(struct hci_dev *hdev)
>  	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
>  }
>  
> +static ssize_t vendor_rst_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	unsigned int val;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
> +
> +	if (!data || !data->hdev)
> +		return -ENODEV;
> +
> +	if (kstrtouint(buf, 10, &val) || val != 0) {
> +		bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
> +		return -EINVAL;
> +	}
> +
> +	bt_dev_info(data->hdev, "PLDR triggered via sysfs");
> +	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);
> +
> +	return count;
> +}
> +
> +static ssize_t vendor_rst_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "0 - PLDR\n");
> +}
> +
> +static DEVICE_ATTR_RW(vendor_rst);
> +
>  static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
>  {
>  	struct btintel_pcie_dev_recovery *rec;
> @@ -3010,6 +3043,11 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>  	if (err)
>  		goto exit_error;
>  
> +	err = device_create_file(&pdev->dev, &dev_attr_vendor_rst);

Can you avoid the manual device_create_file() by taking advantage of
23b6904442d0 ("driver core: add dev_groups to all drivers") and
setting .dev_groups in your struct driver?

If you can, I think it would avoid a race between the device becoming
visible in sysfs (and the uevent announcing that) and the addition of
this sysfs attribute.

> +	if (err)
> +		bt_dev_warn(data->hdev, "Failed to create vendor_rst sysfs (%d)",
> +			    err);
> +
>  	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>  		   data->cnvr);
>  	return 0;
> @@ -3046,6 +3084,8 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>  	disable_work_sync(&data->hwexp_work);
>  	disable_work_sync(&data->fwtrigger_work);
>  
> +	device_remove_file(&pdev->dev, &dev_attr_vendor_rst);
> +
>  	/* Cancel pending reset work. Skip only when remove() is called from
>  	 * within the reset work itself (PLDR device_reprobe path) to avoid
>  	 * deadlock. current_work() returns the work_struct of the caller if
> -- 
> 2.43.0
> 

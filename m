Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092635F184;
	Mon, 27 Jul 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189432; cv=none; b=uxw28gTQilQw3j24QOCwb7Iamwm+Cn9IObFe7k7jJSyubcMwVW7qCjLBO4QMuvHTGX9hzP2g96H9xx6cfpHaPmJLB/VyHtTU978gVAJZGKoWPgHx6uKcCSk1Zx4BJk7G9qdNwsKcMpfMT2zKQNZzG8+e4QHhI//D4pWvoqIwyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189432; c=relaxed/simple;
	bh=DQQUam+BTj/0j6ZZ3giHhBvd/YoRAQhSQH6/0DCbF7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUikAmiyaPNkD0wQGHhgl0q/uJJ8DN1RFGky3ZEn7IYyS5su38q3WO7gGIIZVWjuTjJ0AZD7otyvRs35FW6cBX1jShDU3GsuqyyE/qZTtZG5XIoDHfqoCVj1ZlVAKnRRDdN5zcjy1bwss7hS0QuksgOQK369/eBpHPpI27eN5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=jHx7Ey1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/fgUGL+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="jHx7Ey1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/fgUGL+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0A281400082;
	Mon, 27 Jul 2026 17:57:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Jul 2026 17:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785189427;
	 x=1785275827; bh=lKebyqlD2/dSO9EA4Cey8ady2OFaRSlk0XJ/iG53RZQ=; b=
	jHx7Ey1u33hay41C1tvogI2YFRYaQA2UShrW9qBn/3YfTkYOuKcOwWOMUGxtERbs
	zV1ftZvtUhr1q9Gz6uW8p91tHxn7kGGGuPcv3tuSOXpPluNrf8jaQRSc5ZP+515C
	yIH2RcVWvxejA9UZ061fhKZRwGVJni6BkVRsUGH8k14k7nBb1AS+wHp7RryfxeYj
	WjrNJMeFY9g6uRIgU3Z4DsDIsC25jTStBIQFsB3UnyTDoRFvr91uae3AH+jJ+lgp
	RxEr0BSMz0ZY0o+RByZQZhZL9AQgPfP6sliebk/jpNAZlWbmaj046i7bSUkH2eRV
	Uap1GTi2VrJQS1GrY2uyFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785189427; x=
	1785275827; bh=lKebyqlD2/dSO9EA4Cey8ady2OFaRSlk0XJ/iG53RZQ=; b=X
	/fgUGL+C3lCmU8fSwNSFc7d73wPZFlxLDlARe04W90fAAqAFOCtrCM4ssDzsn1WF
	2DdhAwVXTcctsL+x4CHeYAZBmmwTWLCdUaSlmNOVt7Ue4igJgD+8adoyRdBcRTkv
	hiZCkh9rs2+AJonU5f1zBGSNMj+D632u/FtM5fn9s2p68OLHmhfs0zcUAGtoJzNB
	JkL1Imze2K2ueLndwqV7/J3OBU9QgwQ6oEFIz2N+DDjZUyRsocxPO9dJY/HE/7K7
	aokyMLplR/RKNVD97ldjiZ+sb66+19XU7oBPC0ckYJOFJl37TjoyC6SuVzdR9Ov6
	yX4TU3JRrZ73tWQRfZHcg==
X-ME-Sender: <xms:M9Rnam7tcQ2-5RR09vtWVKvCjT0BM-kAQQrIxek86hcR7cxUNXmqtw>
    <xme:M9Rnak2hx2dqHBrHWTeR5-XEeBUuwduVyXe7aTcuPxvsurSPX15GBq-5bZtEd5xrJ
    cImg-fO4uHKK0tVUmUsy3M7wTM6oZE0l90qQe-ytdmzO08_bkZkQA>
X-ME-Received: <xmr:M9RnapsLZ4XpLBw-g-vXIzhqt0NMhoUzqLj6BsrRmh1TupVgS5ES-leoHcQIjw>
X-ME-Proxy-Cause: dmFkZTEeoNgNe6SoBOcw25T/tm0CLa5qLYpz+Vdzh6dF0Vuk3qSnOl6N2Xg5ZO6Ez2gPaJ
    XtzGoEfGjqqmj8q1mQtl5aT99fKz4Y+tHK9ZyZl/31TcgPojH3oTwJC8UwYpVq6q2qDJXd
    jW0SRyrMRbJ8rhvS9gNT67vEz4DLLOXn8If288UbcmDFPMghM9nm42mc8smn4KN3rm3yi9
    PLmAliYCkjJjp+RbyeTDJL8SOnwDd32h1hZe6JluZnmVR4o3aC02hFl+0vQzJ+Z2lEqizp
    FWHDU3TWYHpUQweYEcw7yQqb1y36eGrepLdH9ugyjHEjAAjXrL3su3Xwz+IEUTggyoDNmW
    U75kYpMykxZkXlbv+NRxjUBIe493mOWBuqqtIgNEfSFdbiT8ye+1HMGil3WzYFSlyNj6rB
    F23eg3CjnLfCgRNaEoJdke0jUxgDkjJ3+hSfTALnOYvCgRg9oL6+l3Qd9femNKa6ieP7YP
    eDhk30fq7kjB4wH4HM4sGc+w8n7v3+BBLCYJqAX8yRUL4heSZTZxSgQRL85vZbXCDryZr4
    RFr7GI5kvVVNc8qayVRQ2XMVickQto4o0SI0qoGlGf0ZoSiddrEGjxx1Gm0chhrytjnK7Q
    f9RvGh8j4+6s8Da8+SVJPgl6uKtkK6U6Abm2TO2kjuUXmgEzB4Hlpz8CWkOQ
X-ME-Proxy: <xmx:M9Rnai7p0o9mL3s7GNlTgtxojwX5APYblZdroejQVw0GGcxn9Ua35g>
    <xmx:M9RnateYu10MEDbhhgbyjCny2itajmUzA0pCL0l3P5CNIk4_AlmwdA>
    <xmx:M9RnanwkMURaYMvLk2norR8GXo9VKg8WyDzpOqmywLRA5ucrQNzwzw>
    <xmx:M9Rnaq8pqs0P1gyaJHz-4Ikm4St00LaHnjiQo5CvvCPTSOB2D_HyHw>
    <xmx:M9RnaqMQkbxl0ZjnJzupSpa_3M5nXLSm_XuhRDSsK3qyYK8xq3SBtRdZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 17:57:06 -0400 (EDT)
Date: Mon, 27 Jul 2026 15:57:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 luiz.dentz@gmail.com, bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com, alex@shazbot.org
Subject: Re: [PATCH v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs
 for PLDR
Message-ID: <20260727155703.4536b6be@shazbot.org>
In-Reply-To: <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
	<20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 10:51:02 +0530
Chandrashekar Devegowda <chandrashekar.devegowda@intel.com> wrote:

> Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_reset
> to allow userspace to trigger PLDR (Product Level Device Reset).
> Reading the attribute displays supported reset types. Writing
> integer 0 triggers PLDR. Any other input is rejected with
> -EINVAL and a warning log.
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> ---
> Changes in v6:
>   - Fixed .driver.dev_groups -> .dev_groups on struct pci_driver
>     (__pci_register_driver overwrites .driver.dev_groups with .dev_groups)
>   - Removed unrelated schedule_work() failure handling from
>     btintel_pcie_request_reset() that caused CI context mismatch
> 
> Changes in v5:
>   - Renamed sysfs from vendor_rst to vendor_reset (reviewer feedback)
>   - Switched from device_create_file() to driver dev_groups for
>     automatic race-free sysfs lifecycle management
>   - Added ABI doc at Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
>   - Added WiFi impact description to ABI documentation
>   - Added MAINTAINERS F: entry for ABI doc
>   - v5: https://lore.kernel.org/all/20260723063520.1149474-1-chandrashekar.devegowda@intel.com/
> 
> Changes in v4:
>   - Rebased on latest bluetooth-next to fix CI apply failure
>   - v4: https://lore.kernel.org/all/20260722012158.813793-1-chandrashekar.devegowda@intel.com/
> 
> Changes in v3:
>   - Dropped reset_type parameter approach from hdev->reset()
>   - Directly call btintel_pcie_request_reset() instead of manual
>     flag manipulation and schedule_work()
>   - Accept only integer 0 for PLDR trigger
>   - v3: https://lore.kernel.org/all/20260722001434.804931-1-chandrashekar.devegowda@intel.com/
> 
> Changes in v2:
>   - Added reset_type parameter to hdev->reset() callback (1/2)
>   - vendor_rst sysfs used reset_type to select PLDR (2/2)
>   - v2: https://lore.kernel.org/all/20260618085016.9173-1-chandrashekar.devegowda@intel.com/
> 
> Changes in v1:
>   - Initial implementation
>   - v1: https://lore.kernel.org/all/20260612012832.2395034-1-chandrashekar.devegowda@intel.com/
>  .../sysfs-bus-pci-drivers-btintel_pcie        | 15 ++++++++
>  MAINTAINERS                                   |  1 +
>  drivers/bluetooth/btintel_pcie.c              | 38 +++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie b/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
> new file mode 100644
> index 000000000000..cceec6ac96bc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/pci/devices/<BDF>/vendor_reset

Nit, domain is present too, not just BDF.

> +Date:		22-Jul-2026
> +KernelVersion:	6.17

Kernel 6.17 was 10 months ago.

> +Contact:	linux-bluetooth@vger.kernel.org
> +Description:	This read-write attribute allows userspace to trigger a
> +		Product Level Device Reset (PLDR) on Intel PCIe Bluetooth
> +		controllers. Reading the attribute displays the supported
> +		reset type. Writing integer 0 triggers PLDR. Any other
> +		input is rejected with -EINVAL.

This is opposite of /sys/bus/pci/devices/<BDF>/reset for no apparent
reason and seems like it infringes on the namespace of sysfs-bus-pci.

> +
> +		PLDR resets the entire on-chip platform shared between
> +		Bluetooth and WiFi. This means any driver attached to
> +		the WiFi device that shares hardware with this Bluetooth
> +		device will be released, the platform will be reset, and
> +		both the Bluetooth and WiFi devices will be re-probed.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb8cdcc76324..39d390f1ceb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4625,6 +4625,7 @@ S:	Supported
>  W:	http://www.bluez.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> +F:	Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
>  F:	Documentation/devicetree/bindings/net/bluetooth/
>  F:	drivers/bluetooth/
>  
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index ef42b8d11d4d..005c77a4f5eb 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2790,6 +2790,43 @@ static void btintel_pcie_hci_reset(struct hci_dev *hdev)
>  	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
>  }
>  
> +static ssize_t vendor_reset_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
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

This is pretty scary on its own, scanning for specific wifi device IDs,
finding the first match and releasing the driver for it while holding
pci_lock_rescan_remove().  So an attribute on one device that unbinds
the driver for another device (or worse, maybe reset it anyway if the
SKUs are out of sync), and the reset happens asynchronously at some
point in the future.  If the wifi device happens to be in use by
vfio-pci, that delay is unbounded as it relies on a userspace driver or
VM to release the device.

> +
> +	return count;
> +}
> +
> +static ssize_t vendor_reset_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "0 - PLDR\n");

It seems like this is implying an enumerable list of resets, but the
API is committing to zero/-EINVAL.  The string also isn't very sysfs
compliant.  Thanks,

Alex

> +}
> +
> +static DEVICE_ATTR_RW(vendor_reset);
> +
> +static struct attribute *btintel_pcie_attrs[] = {
> +	&dev_attr_vendor_reset.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(btintel_pcie);
> +
>  static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
>  {
>  	struct btintel_pcie_dev_recovery *rec;
> @@ -3250,6 +3287,7 @@ static struct pci_driver btintel_pcie_driver = {
>  	.probe = btintel_pcie_probe,
>  	.remove = btintel_pcie_remove,
>  	.driver.pm = pm_sleep_ptr(&btintel_pcie_pm_ops),
> +	.dev_groups = btintel_pcie_groups,
>  #ifdef CONFIG_DEV_COREDUMP
>  	.driver.coredump = btintel_pcie_coredump
>  #endif


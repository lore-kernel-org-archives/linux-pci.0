Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFC2F3C0E
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044669; cv=none; b=hDkmxZY/akDQU1oR+SDVOzObIbDCA0J0XDqB7atCxsQOFVGGbZAiYjh4erSzwkapclGQyPqzfsfKZRJgrAs/1wc+9m9HWyPAPLsnL8BFGEMuIwCqoF3nRCKCSfRJBDDCyYL9cRwRg4hitdbkttPJApEzx/+QX2HcOF243xsHCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044669; c=relaxed/simple;
	bh=g79u3gMKe4oZqB979X3yLwiUop9hrYjCE/ZQ9QdtcQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNszFTb/vEyf430ZgTFukEOz9OL1Se8D+zcgmqh1MXdQghkQAv2EqQauBVx25sgE7a0Cjprq8UNLKPWQX8w3Rj/AP1PEUYdm3IKblizfxJypRv4D8mlap1Ai9j970w+rxTfGKHY3O3QcvI+tNNegeob/R8YKyO1B+2DKOnhqAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkFieru9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkFieru9"
Message-ID: <65228806-6ed3-4577-9037-13fd5eb8f9b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779044655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocLUawCgIiqgFoSO6rtDbcAWX6JsO4JMBPCybL4HayA=;
	b=gkFieru93xndDsQeIR8L/2dWYTkeYNnvRucTZ9LF4xAIwFi8WXcjrY2y6m1YkqL2Y6qXyK
	nLaxwIy6lgJQFur4fYsW9J/s+HrOFNCk0oIqo2jzUFKu4fiCHeDb3OYg7GWHR3xxNBaQ7Q
	IZ+6RApE0nMovOtW1+xr+7ARRbFzvN4=
Date: Sun, 17 May 2026 12:04:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 05/16] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
To: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
 ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net,
 dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
 jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
 kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de,
 michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com,
 praan@google.com, pratyush@kernel.org, rananta@google.com,
 rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org,
 saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com,
 vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-6-vipinsh@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260511234802.2280368-6-vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/5/11 16:47, Vipin Sharma 写道:
> From: David Matlack <dmatlack@google.com>
>
> Enforce that files for incoming (preserved by previous kernel) VFIO
> devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
> opening the corresponding VFIO character device or via
> VFIO_GROUP_GET_DEVICE_FD.
>
> Both of these methods would result in VFIO initializing the device
> without access to the preserved state of the device passed by the
> previous kernel.
>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Co-developed-by: Vipin Sharma <vipinsh@google.com>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>   drivers/vfio/device_cdev.c             |  8 ++++++++
>   drivers/vfio/group.c                   |  9 +++++++++
>   drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
>   drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
>   4 files changed, 41 insertions(+)
>
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 1ab07ccaf3ab..4df0495941c6 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -49,6 +49,14 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep
>   		}
>   
>   		*filep = file;
> +	} else if (vfio_liveupdate_incoming_is_preserved(device)) {
> +		/*
> +		 * Since it is live update preserved device, it must be
> +		 * retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD instead of
> +		 * opening /dev/vfio/devices/vfioX.
> +		 */
> +		ret = -EBUSY;
> +		goto err_free_device_file;

When vfio_liveupdate_incoming_is_preserved(device) returns true, 
vfio_device_put_registration(device) is not called in this path.

Is vfio_device_put_registration(device) instead invoked from the 
err_free_device_file error handling path?

Zhu Yanjun

>   	}
>   
>   	file->private_data = df;
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index b2299e5bc6df..62b4eaabc829 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -316,6 +316,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
>   	if (IS_ERR(device))
>   		return PTR_ERR(device);
>   
> +	/*
> +	 * This device was preserved across a Live Update. Accessing it via
> +	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
> +	 */
> +	if (vfio_liveupdate_incoming_is_preserved(device)) {
> +		vfio_device_put_registration(device);
> +		return -EBUSY;
> +	}
> +
>   	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
>   	if (fd < 0)
>   		vfio_device_put_registration(device);
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index 11c3bc8a8dcd..731a3e34085f 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -47,6 +47,12 @@
>    *   ...
>    *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
>    *
> + * .. note::
> + *    After kexec, if a device was preserved by the previous kernel, attempting
> + *    to open a new file for the device via its character device
> + *    (``/dev/vfio/devices/X``) or via ``VFIO_GROUP_GET_DEVICE_FD`` will fail
> + *    with ``-EBUSY``.
> + *
>    * Restrictions
>    * ============
>    *
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 0854f3fa1a22..5269fe021ee3 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -11,6 +11,7 @@
>   #include <linux/cdev.h>
>   #include <linux/module.h>
>   #include <linux/vfio.h>
> +#include <linux/pci.h>
>   
>   struct iommufd_ctx;
>   struct iommu_group;
> @@ -461,4 +462,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
>   static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
>   #endif /* CONFIG_VFIO_DEBUGFS */
>   
> +#ifdef CONFIG_PCI_LIVEUPDATE
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> +{
> +	struct device *d = device->dev;
> +
> +	if (dev_is_pci(d))
> +		return to_pci_dev(d)->liveupdate_incoming;
> +
> +	return false;
> +}
> +#else
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_PCI_LIVEUPDATE */
> +
>   #endif

-- 
Best Regards,
Yanjun.Zhu


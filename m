Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BC38F255
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074205; cv=none; b=rgrU05k4qBR1dRZb0PsP5wmpvmkHh8EZjWB/LxtbOZ0xBa8qL5oziTqb/ZdI0MvWqtF8+2TbH1R0kq4CGdCXv/1z2OXNs8+n+u5Qk2hF2pr2TMtBdHvgHLk5HZ+B+F8BGCj+FsiuPwonYAUoktAzbI1n36l2k1wciFCUCx9VAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074205; c=relaxed/simple;
	bh=+jaF5uQc6mezs36JAknZrO43Y8rhs0xWbbCDtvpHPzg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poqtOHVIOWbfXrEFaIGal9AEhwWSrV0fZh42yM74JOPTF6ii80a/MuxPwI1h7/P/HvFkchNksO2P0JZILs7ioy0dhHQmrMzCNzkurtn7xKlc0W406B4Q3HBXGTSzXl0WFgFAqYo8p41JegMZtScWPb3CMhZyAzob54XmdBs9lyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV2hg6H9YzHnH52;
	Tue, 10 Mar 2026 00:36:35 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E7CA840585;
	Tue, 10 Mar 2026 00:36:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 16:36:39 +0000
Date: Mon, 9 Mar 2026 16:36:37 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>
Subject: Re: [PATCH v2 01/19] PCI/TSM: Report active IDE streams per host
 bridge
Message-ID: <20260309163637.00003046@huawei.com>
In-Reply-To: <20260303000207.1836586-2-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
	<20260303000207.1836586-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  2 Mar 2026 16:01:49 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The first attempt at an ABI for this failed to account for naming
> collisions across host bridges:
> 
> Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> 
> Revive this ABI with a per host bridge link that appears at first stream
> creation for a given host bridge and disappears after the last stream is
> removed.
> 
> For systems with many host bridge objects it allows:
> 
>     ls /sys/class/tsm/tsmN/pci*/stream*
> 
> ...to find all the host bridges with active streams without first iterating
> over all host bridges. Yilun notes that is handy to have this short cut [1]
> and from an administrator perspective it helps with inventory for
> constrained stream resources.
> 
> Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 8712df8596a1..3c99c38cfaa5 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -4,10 +4,12 @@

> +
> +static struct tsm_ide_stream *create_streams(struct tsm_dev *tsm_dev,
> +					    struct pci_host_bridge *bridge)
> +{
> +	int rc;
> +
> +	struct tsm_ide_stream *streams __free(kfree) =
> +		kzalloc(sizeof(*streams), GFP_KERNEL);

Crossed with kzalloc_obj() etc being introduced which seems appropriate here.
 
> +	if (!streams)
> +		return NULL;
> +
> +	streams->tsm_dev = tsm_dev;
> +	streams->bridge = bridge;
> +	kref_init(&streams->kref);
> +	rc = xa_insert(&tsm_ide_streams, (unsigned long)bridge, streams,
> +		       GFP_KERNEL);
> +	if (rc)
> +		return NULL;
> +
> +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &bridge->dev.kobj,
> +			       dev_name(&bridge->dev));
> +	if (rc) {
> +		xa_erase(&tsm_ide_streams, (unsigned long)bridge);
> +		return NULL;
> +	}
> +
> +	return no_free_ptr(streams);
> +}



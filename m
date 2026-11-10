Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794317807;
	b=krRV+0Ee/eqGYZLVtw5W0CvDi1MMCW/eXu1WtS/8RCOKr23yDu5aX2GttF15Bj7oIO//
	 b2thyurh7VjN3I9Zf2qQ+eg33v64Kb/wJkVutKlB30+ynFaVQgxcHwMZmkMaU0GaCAWzt
	 AfpUQyqjBrah4rG1EhiXUN32y7bbqRh198xdVIWdXaSOqA2bfD8fSqsWpLsroBxG6tZ1w
	 nrZLyrwyC4r6KeC+V8tp5PFQjvvIYv3vzdo2yQExYCNsuXUt+ADSR80uBKKKIShsCZmrQ
	 uWTtHAlQlhPlApBkTT2wnWZF07yKasgEDwBk4+ZDFO9Uw7AiSZsrL51qys4eDZE2xqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317807;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=0azMahU3OokpLVsuQ5UXOF5UyDmli+pSUQLgONyqu+4=;
	b=U3V5T3e8nGmN9P6qkV0LHrb5ZMNS7S4kLSyIkGF987uSs79S4HlniszNapgOZ3ktkyOq
	 P9wJkhJpYbLxFuu918oi7PCxwaUFXa96pMWxw04yjFwyKsGshZyX2whSDPrERbz2S2vq2
	 xMXHjOpVHrrlWKQylGJ5EJqJb09gsM9O7fJhVgzfoBWp6zH0p1QsFBODLrl258gv/lTTB
	 dSCtXe+ghTYVcyIYb0QPH+GtU+FUBOW0CAIx6s4iK8KbAh42zKC0lNSTQ7HeMplfL5KRX
	 mdxQxVKZAJ90dCS/84fvNmxYM6VFV05tDMF0iNNFz/QQT84n/v2ilD4zwss83ltrxwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Uahep5AR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E78606A74C;
	Tue, 10 Nov 2026 13:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E78606A74C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Uahep5AR
ARC-Seal: i=1; a=rsa-sha256; t=1794317778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K4/+UttRAjzAJ3tYTbL5chZCJ5VRYGIvtDflTCJkgEt4DbDydg5RAmAbarg8p+uCcJUOUYOoCJGRwe8Z/FD5PlkcUf0Y9DpvJtryT619TE9IS9NWNPSCfJTQ8xTpoeJ1QC+0GdEw6r0KWxE7bpAjMaYA+3oA/F2yqUcp2dAeN8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794317778; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0azMahU3OokpLVsuQ5UXOF5UyDmli+pSUQLgONyqu+4=; 
	b=LqNg3qfY7VB9fLy5VfuDjI4o28UPGBLncjpx1Y6lOwXxcBX1YWueXy4rpZEibW7t52hoAQo0SqF0YHrIS0iw5wW0QdmLoLq52Z8TBpp975nqetk8Z4Rmc6GwWaCHoh+tJieSewj820E3qSCGP8+dR5k0iVzQpsN4o0V988461HA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Uahep5ARfTOcVThz/h0awv+3+zSEEIu2EMY9g+co7qXLTPHvF+z8xOcw0JJ7yH9mNyeZysNLWp+Ml4VqHV5vRDJQqxHD86MfAqkNeLMZzaZFuja08+HrNxZqsBNGJHnumbvTm9k4Nyec6/2iP9yj+AxbtsK9yG8eK99gye/2iJ0=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=0azMahU3OokpLVsuQ5UXOF5UyDmli+pSUQLgONyqu+4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794317777710817.8057734110412;
	Tue, 10 Nov 2026 05:36:17 -0800 (PST)
Message-ID: <f67ecd0e-1eae-41b1-8a61-d06eb062e523@zohomail.com>
Date: Tue, 10 Nov 2026 21:36:08 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/19] cxl: Share CXL port upstream PCI device lookup
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-3-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261105185917.2667656-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227cd6656a0b0b917d8a199c6e100004c38c21d393ffd7344d61fa92497026c4e4ee171ecce232c3e:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/6 02:59, Srirangan Madhavan 写道:
> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
>
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
> PCI device to make caller ownership explicit.
>
> Use automatic reference cleanup in read_cdat_data(), as suggested by
> Li Ming, so early returns release the PCI device reference.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
>
> ---
> Changes in v17:
> - Use an explicit pci_dev_put() on a single exit path in
>    read_cdat_data() instead of mixing __free() with goto cleanup
>    (Sashiko)
>    https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=2

Reviewed-by: Li Ming <ming.li@zohomail.com>


I still think the new goto makes the code harder to follow. But I saw 
your discussion in v13[1], both Jonathan and Dave agree with your 
current changes. I post my proposal here which can eliminate all goto 
labels. If there is no response from them, or if they disagree with my 
changes, we can continue with your implementation.

[1]: 
https://lore.kernel.org/all/fb513893-7c6c-408c-811f-1eae20f0436c@intel.com/

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..fbf4b56a39c4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -573,17 +573,8 @@ void read_cdat_data(struct cxl_port *port)
         size_t table_length, length;
         int rc;

-       if (is_cxl_memdev(uport)) {
-               struct device *host;
-
-               cxlmd = to_cxl_memdev(uport);
-               host = cxlmd->dev.parent;
-               if (dev_is_pci(host))
-                       pdev = to_pci_dev(host);
-       } else if (dev_is_pci(uport)) {
-               pdev = to_pci_dev(uport);
-       }
-
+       struct pci_dev *pdev __free(pci_dev_put) =
+                               cxl_port_get_uport_pci_dev(port);
         if (!pdev)
                 return;

@@ -606,30 +597,32 @@ void read_cdat_data(struct cxl_port *port)
          * bytes for the DOE header. Table data starts afterwards.
          */
         buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
-       if (!buf)
-               goto err;
+       if (!buf) {
+               dev_err(dev, "Failed to allocate CDAT buffer.\n");
+               return;
+       }

         table_length = length;

         rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
-       if (rc)
-               goto err;
+       if (rc) {
+               devm_kfree(dev, buf);
+               dev_err(dev, "Failed to read CDAT.\n");
+               return;
+       }

         if (table_length != length)
                 dev_warn(dev, "Malformed CDAT table length (%zu:%zu), 
discarding trailing data\n",
                         table_length, length);

-       if (cdat_checksum(buf->data, length))
-               goto err;
+       if (cdat_checksum(buf->data, length)) {
+               devm_kfree(dev, buf);
+               dev_err(dev, "Failed to validate CDAT.\n");
+               return;
+       }

         port->cdat.table = buf->data;
         port->cdat.length = length;
-
-       return;
-err:
-       /* Don't leave table data allocated on error */
-       devm_kfree(dev, buf);
-       dev_err(dev, "Failed to read/validate CDAT.\n");
  }


> ---
>   drivers/cxl/core/core.h |  1 +
>   drivers/cxl/core/pci.c  | 24 ++++++------------------
>   drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..983d7690c3a5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>   int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>   					struct access_coordinate *c);
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
>   
>   static inline struct device *port_to_host(struct cxl_port *port)
>   {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..905892cfedef 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>    */
>   void read_cdat_data(struct cxl_port *port)
>   {
> -	struct device *uport = port->uport_dev;
> +	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
>   	struct device *dev = &port->dev;
>   	struct pci_doe_mb *doe_mb;
> -	struct pci_dev *pdev = NULL;
> -	struct cxl_memdev *cxlmd;
>   	struct cdat_doe_rsp *buf;
>   	size_t table_length, length;
>   	int rc;
>   
> -	if (is_cxl_memdev(uport)) {
> -		struct device *host;
> -
> -		cxlmd = to_cxl_memdev(uport);
> -		host = cxlmd->dev.parent;
> -		if (dev_is_pci(host))
> -			pdev = to_pci_dev(host);
> -	} else if (dev_is_pci(uport)) {
> -		pdev = to_pci_dev(uport);
> -	}
> -
>   	if (!pdev)
>   		return;
>   
> @@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
>   				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>   	if (!doe_mb) {
>   		dev_dbg(dev, "No CDAT mailbox\n");
> -		return;
> +		goto out;
>   	}
>   
>   	port->cdat_available = true;
>   
>   	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>   		dev_dbg(dev, "No CDAT length\n");
> -		return;
> +		goto out;
>   	}
>   
>   	/*
> @@ -624,12 +611,13 @@ void read_cdat_data(struct cxl_port *port)
>   
>   	port->cdat.table = buf->data;
>   	port->cdat.length = length;
> -
> -	return;
> +	goto out;
>   err:
>   	/* Don't leave table data allocated on error */
>   	devm_kfree(dev, buf);
>   	dev_err(dev, "Failed to read/validate CDAT.\n");
> +out:
> +	pci_dev_put(pdev);
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>   
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..5dc2815d82d8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,6 +34,32 @@
>   static DEFINE_IDA(cxl_port_ida);
>   static DEFINE_XARRAY(cxl_root_buses);
>   
> +/**
> + * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
> + * @port: CXL port to map to a PCI device
> + *
> + * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
> + * The caller must release the returned reference with pci_dev_put().
> + */
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
> +{
> +	struct device *uport = port->uport_dev;
> +	struct device *host;
> +
> +	if (is_cxl_memdev(uport)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +
> +		host = cxlmd->dev.parent;
> +	} else {
> +		host = uport;
> +	}
> +
> +	if (!host || !dev_is_pci(host))
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(host));
> +}
> +
>   /*
>    * The terminal device in PCI is NULL and @platform_bus
>    * for platform devices (for cxl_test)

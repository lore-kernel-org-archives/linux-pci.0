Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585007;
	b=cUwmGkja8Xtt/pPfbW7gp3NXJ5S536WPDBR0HmdP+j5ArBRV82LojDAvwD+3N5cPzynF
	 FzUE1ngM4TIE6Mi1e3STQXyiXZdzqPgkd5lPZmbuEMqe+S8dKVP/6Wwm6CUcWY9lni2GP
	 jwjMhc/TKoCO+miaqQH0nznE3Btk38O2/6mLveSRw1yayNfKEAvsNPZQVcmxWQx1rflHQ
	 k2FPs478LqZ28khHvDkL4vaL90g3zhjTn2SbslpD/FGxPfYoRi6dnOCLUH3LHoKrezn3h
	 bPOMHuD1v6lOVKhsX0O6CjsK5UoR1wvcOQdJDGMsABOc7GN4mztCQhsd7Kd2xhmlk1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585007;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1fdNPQNo+zffU2XGvMztEYgcvEonGMt5d76mOcozsng=;
	b=xh5Hrsff90mYe5h0YAY+Ecff85KYLEZjb6SDUEmjn4zDVooygxgJMIYP2DdRVxtlf5WQ
	 1qDlU49oWPOKxRB8uhAhoo2p2hHWg8Pdjlhz+hde4FJjmxo2JigBFhSk5Sh8+ONUbXyRD
	 BRDv3+W23Ms170cOa97+GbXXMw0Hi1N3tNd1RYnHpvflR+3vkB1hKgA3t+FyXEiw7av3W
	 iQOQqDWwz+14gDDRB5SEMjwZv4sEzRbHhoCtFmhF308/91TL4MXIvHsgSsGAQ/dVGLg99
	 E8ZQgUh5OAAwoKvq+WyyzpFIpnFe4Yd+dIUNtRKAsbP6F0DX5k/rrwzxZtsBZfqLAlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZZSodsM2;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CA606A323;
	Fri, 13 Nov 2026 15:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19CA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZZSodsM2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794585007; x=1826121007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YsT24gl9bIBDYikNQDcSGfV6q4rVg9ESg3hLJA/uCQ8=;
  b=ZZSodsM2INg30DhZG7rgqrvR75fAz5DJSb5lfn++34kpYvf0ZvBqipy+
   0nm1BCCdeeXQ0ubAl1oRrTwj7erFoEbbSKrAwqwKbfQxL/PgXu81tObaW
   gq67z7X5JdQOIfRTUW7NlKtJ/EqFVlQLn0LK3cZgWDlHrVASLj7u+gXnv
   ppZK5K0qUMZCmZvn2W711PmhAgudKyK+JEQx3Kzy99/EvHWHCX0k+Chg4
   yTGLpRVd4OmSiic8tBK27JXdsP62ru0G1BmMPBMye4Ozo4Vb1JZOfNhU7
   C6ryIvNvTwgr6BEGIzNiGVpL4qLWs4SKZCiRFUzL2TcEpKWtA6/glIaPN
   Q==;
X-CSE-ConnectionGUID: EiTpJCsgSqivv87l2dyICg==
X-CSE-MsgGUID: 4Dqdt7OcTraBkWGBhXW+Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3296529"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3296529"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:50:06 -0800
X-CSE-ConnectionGUID: pHHvl0FESI25HZ01XTTXGg==
X-CSE-MsgGUID: O/ls2e+cR82ikmCG7eZEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9494890"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.6]) ([10.125.108.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:50:04 -0800
Message-ID: <70b69d4c-34b2-4166-9e3c-fbd9e21daf75@intel.com>
Date: Fri, 13 Nov 2026 08:50:03 -0700
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
To: Li Ming <ming.li@zohomail.com>, Srirangan Madhavan
 <smadhavan@nvidia.com>, Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
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
 <f67ecd0e-1eae-41b1-8a61-d06eb062e523@zohomail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <f67ecd0e-1eae-41b1-8a61-d06eb062e523@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/26 6:36 AM, Li Ming wrote:
> 
> 在 2026/11/6 02:59, Srirangan Madhavan 写道:
>> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
>> device. HDM cache updates need the same mapping.
>>
>> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
>> PCI device to make caller ownership explicit.
>>
>> Use automatic reference cleanup in read_cdat_data(), as suggested by
>> Li Ming, so early returns release the PCI device reference.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Richard Cheng <icheng@nvidia.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>
>> ---
>> Changes in v17:
>> - Use an explicit pci_dev_put() on a single exit path in
>>    read_cdat_data() instead of mixing __free() with goto cleanup
>>    (Sashiko)
>>    https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=2
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
> I still think the new goto makes the code harder to follow. But I saw your discussion in v13[1], both Jonathan and Dave agree with your current changes. I post my proposal here which can eliminate all goto labels. If there is no response from them, or if they disagree with my changes, we can continue with your implementation.
> 
> [1]: https://lore.kernel.org/all/fb513893-7c6c-408c-811f-1eae20f0436c@intel.com/
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..fbf4b56a39c4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -573,17 +573,8 @@ void read_cdat_data(struct cxl_port *port)
>         size_t table_length, length;
>         int rc;
> 
> -       if (is_cxl_memdev(uport)) {
> -               struct device *host;
> -
> -               cxlmd = to_cxl_memdev(uport);
> -               host = cxlmd->dev.parent;
> -               if (dev_is_pci(host))
> -                       pdev = to_pci_dev(host);
> -       } else if (dev_is_pci(uport)) {
> -               pdev = to_pci_dev(uport);
> -       }
> -
> +       struct pci_dev *pdev __free(pci_dev_put) =
> +                               cxl_port_get_uport_pci_dev(port);
>         if (!pdev)
>                 return;
> 
> @@ -606,30 +597,32 @@ void read_cdat_data(struct cxl_port *port)
>          * bytes for the DOE header. Table data starts afterwards.
>          */
>         buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
> -       if (!buf)
> -               goto err;
> +       if (!buf) {
> +               dev_err(dev, "Failed to allocate CDAT buffer.\n");
> +               return;
> +       }
> 
>         table_length = length;
> 
>         rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
> -       if (rc)
> -               goto err;
> +       if (rc) {
> +               devm_kfree(dev, buf);
> +               dev_err(dev, "Failed to read CDAT.\n");
> +               return;
> +       }
> 
>         if (table_length != length)
>                 dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
>                         table_length, length);
> 
> -       if (cdat_checksum(buf->data, length))
> -               goto err;
> +       if (cdat_checksum(buf->data, length)) {
> +               devm_kfree(dev, buf);
> +               dev_err(dev, "Failed to validate CDAT.\n");
> +               return;
> +       }
> 
>         port->cdat.table = buf->data;
>         port->cdat.length = length;
> -
> -       return;
> -err:
> -       /* Don't leave table data allocated on error */
> -       devm_kfree(dev, buf);
> -       dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
> 
> 

How about something like this? I think it's cleaner:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 905892cfedef..c924904faec4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -556,6 +556,27 @@ static unsigned char cdat_checksum(void *buf, size_t size)
 	return sum;
 }
 
+static int cxl_cdat_read_validate(struct device *dev,
+				  struct pci_doe_mb *doe_mb,
+				  struct cdat_doe_rsp *buf, size_t *length)
+{
+	size_t table_length = *length;
+	int rc;
+
+	rc = cxl_cdat_read_table(dev, doe_mb, buf, length);
+	if (rc)
+		return rc;
+
+	if (table_length != *length)
+		dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
+			 table_length, *length);
+
+	if (cdat_checksum(buf->data, *length))
+		return -EIO;
+
+	return 0;
+}
+
 /**
  * read_cdat_data - Read the CDAT data on this port
  * @port: Port to read data from
@@ -564,13 +585,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *doe_mb;
 	struct cdat_doe_rsp *buf;
-	size_t table_length, length;
-	int rc;
+	size_t length;
 
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(port);
 	if (!pdev)
 		return;
 
@@ -578,14 +599,14 @@ void read_cdat_data(struct cxl_port *port)
 				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
-		goto out;
+		return;
 	}
 
 	port->cdat_available = true;
 
 	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
 		dev_dbg(dev, "No CDAT length\n");
-		goto out;
+		return;
 	}
 
 	/*
@@ -593,31 +614,15 @@ void read_cdat_data(struct cxl_port *port)
 	 * bytes for the DOE header. Table data starts afterwards.
 	 */
 	buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
-	if (!buf)
-		goto err;
-
-	table_length = length;
-
-	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
-	if (rc)
-		goto err;
-
-	if (table_length != length)
-		dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
-			table_length, length);
-
-	if (cdat_checksum(buf->data, length))
-		goto err;
+	if (!buf || cxl_cdat_read_validate(dev, doe_mb, buf, &length)) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, buf);
+		dev_err(dev, "Failed to read/validate CDAT.\n");
+		return;
+	}
 
 	port->cdat.table = buf->data;
 	port->cdat.length = length;
-	goto out;
-err:
-	/* Don't leave table data allocated on error */
-	devm_kfree(dev, buf);
-	dev_err(dev, "Failed to read/validate CDAT.\n");
-out:
-	pci_dev_put(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794713162;
	b=t1yW1IKcutwyhQBcKDjFcxxuUfEymFf+z8j0w+60sQ56CpMay3eliJTVRzRtVogGQhob
	 VLxuF1rZ+mjBK0ZxuqhBb5ScUMFN1f2Q0zHI2ECUo/GjJnXWI0dU5w+UKvwLQak8o7aru
	 gtR/GWHTBqcsXharRjQzF5uxMKT/+904sjiZxu0EBlQDCKWw9Ml/4Aqv0V891F3OW/8qI
	 lOMIl2+DMQhBVJafuzcAACIUS96/uPw4RT52n6cWSXLVHxSdGZM6KTCg3E6qBgQEU0vwU
	 q/msTydoJCD5HrLcT+RMiDti7o4z2P7xXfCm+9oL42jQ1T89OWrtx3pmYrLFY8TQaUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713162;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=fCr4vk87uIVxv+fnbM3PawDMY6ycKwKe/urALmU/BHM=;
	b=I7ENaqqr+OpepffNDVtTSDwlFNfiB6gHo5236GLyakVUDpoHDHNWK3YO9UCrBWDou5Qj
	 z7cEWPu/xzoAlhj3XlmpOUbRGw6RaTq3s3rXoAaYzGCZxxSvMxNlChiJEGTNKT3UKLGWK
	 SXun6MEpjt/INmkukdoSiWPOlP4y2dwCu0El886J/JeBSSTth2jLT27E4HgSzI0eJBiFB
	 jAZKHWiz5DEtnTwGp5dBNK1yiR3AwrUhrHAA80TJjz9UpibGRJBSFS6kAHTBhUiQ+PRs9
	 qbdsGYv/HPihq3Ndnvp/bv5IvNENjo9JpMRWHWOkIhOM4eAmKGs09Rf6pnWUL5uR5cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Cy8fGPlD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D9606A323;
	Sun, 15 Nov 2026 03:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 929D9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Cy8fGPlD
ARC-Seal: i=1; a=rsa-sha256; t=1794713142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RnYPPLKJ0/JhnoarrVShf55nqGCNKuZ4WoBuHA6NEs5Xc5b1ff9d1DK3GvFZdYAztmwTHcPgKhF5wJvJRBSLl6xR9j+8MUixo3g0XrQwLewxsgTwBUPQogunBrThGIwuvfDONLvy0FH1+vkfV1oqVfopM7aAG8Q6ZlmJnz707P0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794713142; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fCr4vk87uIVxv+fnbM3PawDMY6ycKwKe/urALmU/BHM=; 
	b=Z8Ln1fTR8MuZALc6w55eEJxfgTmKP8k+G2dL8sAfrh/zjGI/Llr10jCqdyR26DfnLygPLP2h19jF7u3vt17SYc5Nrfs9jbBPzXC2l4TA7xOEUYbntjmSdLkWjTQCtApEsvXWi+3plfDqKgvRVoLT6DMATP8PZJD+cB+eqHWRdWY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Cy8fGPlDwJoV1lzxCVd82pP5Lwlmxrv8CDIda94qu3b26750NDRwUcK+fnWcQ/by5A4oWCURxo9JP1aSRk/2ugkrTG2J+o4ICTj/inUb423AsBqQ6aMNrNd8LWKjyqsBQGtUbvKWycCa/yDkSJ32QRiwyWmk/bqMIbXEZL6Dv1k=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=fCr4vk87uIVxv+fnbM3PawDMY6ycKwKe/urALmU/BHM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794713140424547.7867298639073;
	Sat, 14 Nov 2026 19:25:40 -0800 (PST)
Message-ID: <2e8e3f34-b252-415f-8eb5-ceb1db668175@zohomail.com>
Date: Sun, 15 Nov 2026 11:25:28 +0800
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
To: Dave Jiang <dave.jiang@intel.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
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
 <70b69d4c-34b2-4166-9e3c-fbd9e21daf75@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <70b69d4c-34b2-4166-9e3c-fbd9e21daf75@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227ad363084d4183c4ef58ab89800004bcd12f20718ed38e92b1557a58da56d825851b8e75eaace76:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 11/13/2026 11:50 PM, Dave Jiang wrote:
>
> On 11/10/26 6:36 AM, Li Ming wrote:
>> 在 2026/11/6 02:59, Srirangan Madhavan 写道:
>>> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
>>> device. HDM cache updates need the same mapping.
>>>
>>> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
>>> PCI device to make caller ownership explicit.
>>>
>>> Use automatic reference cleanup in read_cdat_data(), as suggested by
>>> Li Ming, so early returns release the PCI device reference.
>>>
>>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Richard Cheng <icheng@nvidia.com>
>>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>>
>>> ---
>>> Changes in v17:
>>> - Use an explicit pci_dev_put() on a single exit path in
>>>    read_cdat_data() instead of mixing __free() with goto cleanup
>>>    (Sashiko)
>>>    https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=2
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>
>>
>> I still think the new goto makes the code harder to follow. But I saw your discussion in v13[1], both Jonathan and Dave agree with your current changes. I post my proposal here which can eliminate all goto labels. If there is no response from them, or if they disagree with my changes, we can continue with your implementation.
>>
>> [1]: https://lore.kernel.org/all/fb513893-7c6c-408c-811f-1eae20f0436c@intel.com/
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9d807c1a002c..fbf4b56a39c4 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -573,17 +573,8 @@ void read_cdat_data(struct cxl_port *port)
>>         size_t table_length, length;
>>         int rc;
>>
>> -       if (is_cxl_memdev(uport)) {
>> -               struct device *host;
>> -
>> -               cxlmd = to_cxl_memdev(uport);
>> -               host = cxlmd->dev.parent;
>> -               if (dev_is_pci(host))
>> -                       pdev = to_pci_dev(host);
>> -       } else if (dev_is_pci(uport)) {
>> -               pdev = to_pci_dev(uport);
>> -       }
>> -
>> +       struct pci_dev *pdev __free(pci_dev_put) =
>> +                               cxl_port_get_uport_pci_dev(port);
>>         if (!pdev)
>>                 return;
>>
>> @@ -606,30 +597,32 @@ void read_cdat_data(struct cxl_port *port)
>>          * bytes for the DOE header. Table data starts afterwards.
>>          */
>>         buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
>> -       if (!buf)
>> -               goto err;
>> +       if (!buf) {
>> +               dev_err(dev, "Failed to allocate CDAT buffer.\n");
>> +               return;
>> +       }
>>
>>         table_length = length;
>>
>>         rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
>> -       if (rc)
>> -               goto err;
>> +       if (rc) {
>> +               devm_kfree(dev, buf);
>> +               dev_err(dev, "Failed to read CDAT.\n");
>> +               return;
>> +       }
>>
>>         if (table_length != length)
>>                 dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
>>                         table_length, length);
>>
>> -       if (cdat_checksum(buf->data, length))
>> -               goto err;
>> +       if (cdat_checksum(buf->data, length)) {
>> +               devm_kfree(dev, buf);
>> +               dev_err(dev, "Failed to validate CDAT.\n");
>> +               return;
>> +       }
>>
>>         port->cdat.table = buf->data;
>>         port->cdat.length = length;
>> -
>> -       return;
>> -err:
>> -       /* Don't leave table data allocated on error */
>> -       devm_kfree(dev, buf);
>> -       dev_err(dev, "Failed to read/validate CDAT.\n");
>>  }
>>
>>
> How about something like this? I think it's cleaner:

Hi Dave,


Your implementation also works for me.


Ming

>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 905892cfedef..c924904faec4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -556,6 +556,27 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>  	return sum;
>  }
>  
> +static int cxl_cdat_read_validate(struct device *dev,
> +				  struct pci_doe_mb *doe_mb,
> +				  struct cdat_doe_rsp *buf, size_t *length)
> +{
> +	size_t table_length = *length;
> +	int rc;
> +
> +	rc = cxl_cdat_read_table(dev, doe_mb, buf, length);
> +	if (rc)
> +		return rc;
> +
> +	if (table_length != *length)
> +		dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
> +			 table_length, *length);
> +
> +	if (cdat_checksum(buf->data, *length))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -564,13 +585,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
>  	struct device *dev = &port->dev;
>  	struct pci_doe_mb *doe_mb;
>  	struct cdat_doe_rsp *buf;
> -	size_t table_length, length;
> -	int rc;
> +	size_t length;
>  
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(port);
>  	if (!pdev)
>  		return;
>  
> @@ -578,14 +599,14 @@ void read_cdat_data(struct cxl_port *port)
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> -		goto out;
> +		return;
>  	}
>  
>  	port->cdat_available = true;
>  
>  	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> -		goto out;
> +		return;
>  	}
>  
>  	/*
> @@ -593,31 +614,15 @@ void read_cdat_data(struct cxl_port *port)
>  	 * bytes for the DOE header. Table data starts afterwards.
>  	 */
>  	buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
> -	if (!buf)
> -		goto err;
> -
> -	table_length = length;
> -
> -	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
> -	if (rc)
> -		goto err;
> -
> -	if (table_length != length)
> -		dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
> -			table_length, length);
> -
> -	if (cdat_checksum(buf->data, length))
> -		goto err;
> +	if (!buf || cxl_cdat_read_validate(dev, doe_mb, buf, &length)) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, buf);
> +		dev_err(dev, "Failed to read/validate CDAT.\n");
> +		return;
> +	}
>  
>  	port->cdat.table = buf->data;
>  	port->cdat.length = length;
> -	goto out;
> -err:
> -	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, buf);
> -	dev_err(dev, "Failed to read/validate CDAT.\n");
> -out:
> -	pci_dev_put(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");



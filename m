Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02C3D7D64;
	Tue, 25 Aug 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696327; cv=none; b=r6sGTcd7oga6l71ya3xeSM1NEJuZPVoJ73f/bhnPQkLBKkKXiY6n6hSLj6ceqyzlAJEb0D7mj5fgiCCwZrUQ2+f3oeLbj+rUD5TkqNOuFg0KsUusVOMqssfSX6+2aYY/ae3D/Sp9Fo2joAievlU3vqhhW67kJFl6BCv9YIC7ixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696327; c=relaxed/simple;
	bh=GRSprL89g8KwxCCZBOedFkXrZGtaPJpQUg2j1eBIuYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHLvzXzKlTEFyDPKyfqNR9V1i6WJuGeyoGW01m27mDbeFVlEN0PpdNiS0JwuoS+4c6+vf+cJgVJH9lea3KB6GL+JhK5EFJo3fxnlU6KaZ9vh1TpRoNRbVTPcTgrgiryzOgySWjUJanXmcHNVcpdEAcd7gu/kmHgzhTQqNV1kgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=E9yT43Vs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZtdtjkk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="E9yT43Vs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZtdtjkk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 924FFEC0226;
	Tue, 25 Aug 2026 18:18:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 25 Aug 2026 18:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787696324;
	 x=1787782724; bh=DS1rqdlZjbF5D6n64SjidqCOql965Pf+tbcCHMSWHL4=; b=
	E9yT43VsoKGiFH9z0/GJUpUWsY/Wxd8+QpixpsV35DZlIMj9QFGC4ZCyCoOSbbf4
	hB4kWhYql7aKVCK3Xkigjht7Tk5EhG4kT5tM0zXJQv6ZehJ9SNFAjBNK3ECDF96J
	69RSFH8vw8B1puOPNudzO0+ePzu0Xf6dMIvnultLbXqk16HB8P1hdPYLfHIbkOdM
	OsCN2tc62P5Wd43VM5+kuI9PuJsjyWU6bHdhIRXRePejVBkop+1b7WQSKBYhXGE8
	NFouwFaxQj3YIDeEs1Fig9bB7nqzkatLKqvKogy+C2ZAjnphOlfc+9cyHCvfXvp1
	7UI22vP3wuEno0eJGKp9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787696324; x=
	1787782724; bh=DS1rqdlZjbF5D6n64SjidqCOql965Pf+tbcCHMSWHL4=; b=W
	ZtdtjkkzmSfCUlaaABoK7L0l7QCiOhIrrYPabDuMrW+M2qlNVTnu+G2Rv2wqIK4k
	dnnAfREF90j8aF3RRmX0iRYTSn2uouJBRM23t9TI6KsseThv0frzvBh3x9hvF+o4
	lIcGcJf9YXrWVbHgl/t0kJckzwvhH648/Lvc+LbfK9u8Osipat+dK84BqhGWrRxX
	i8tRRCUwHLSODDs1a/y0WnFBm54VF9U6WzlMcnguRmNvS5hycTZizOc6apaWujnp
	lsqIaonbHkUc7RgrbTqKIaFZ441WA13PSEMbYo9H40x70dA20IordEVq+7eQClWZ
	zyeIRppiUTRP2MDYMPR1g==
X-ME-Sender: <xms:xBSOavFxHl-UJ3goCl2YrGlZitprkBNx_KoYaHXPEQ_DFy8CXNv5oA>
    <xme:xBSOagnWqLSNSjopKQHWik0dskIQw6MXqrhM0StIS3DG29eOXl6Hau9LB1d1owQQ_
    1i2IIgoCBcId50G2tBuY4XOb3Wds2m5gxKssFsvRofhNs6wSZuFseo>
X-ME-Received: <xmr:xBSOauHvYsT87A3mFfuTyGaayg4N6X67SvpK7wvQa9-y3qlYf6ouP_8ZfTa73Q>
X-ME-Proxy-Cause: dmFkZTEmJqB+14a23EMh3zlbGN5McyDDOFH3/cb967qFV3hOvQQBCN+8jLhN2laifAEsA+
    tjqL4YOdn902aZdmyOsHt4ZkcRH6ifdB6xqBYnBbxdJjM2YxmWv1QPQcN4MzUvpafah5rL
    sAK7tkszXhn+LUFo/2HeQFtXTSnT5en1V5shSSgnXCnPyHuGDQMITW2T6YTrpBsSHDuttw
    M6RdsUSZu85nrF01VSk7EFuHCISU6y+f8ZS2wIObiqTSQRrK44l/efaRvcrd1nzXBvyF/x
    P3nl1gecL1Icbn0H/2mWMT+2J9+dUqJRXZxKZ9lW1ZKHmxRo+GTEvgmMrBt1VE44XdX5Ef
    7KuJl18j90LFJHcYZQkGzjWowY66kzS94nJqtcDnDTnQ2q7/T+HR9TrSc6wOl7oT2rtEHh
    rMqd/ShYLU+83Y7VUaQ9UPkkeAxEvLUYF/Z8K1rLBZMcfvkW2KH3maG7RVjPbXSc2tCPbq
    FctdaASa2Uee5VS0zXiB5//4sXo/sW5bgk8LhwTZGI9032Vv6fxTk/dJGXPdWKcmmkEsNt
    qSEw7XNRuQkFSdexEUsrdWdTTTw2RrF5NYvvFrG3IisYKa+60KW6WPC/ZTUZHBqVzeD6Zk
    MCwLHN4a1vIb7r5k/pRY0d4lX64h5ChPyWmqPw1J08paB9bmf5AGsI+r+d8g
X-ME-Proxy: <xmx:xBSOarzJn6b2XJc9vnZarCYhS_OvVB3tbCM9v1aBJFe9mCepSF8MlA>
    <xmx:xBSOavYXdo1s9vnqiYtTgxOjzOI9Nr-IhkmETHNvf5KcNI12kKOTmQ>
    <xmx:xBSOaulT7HwoF5dOU4wU60-juqQ2U99Sath7ssCZ4eLPv06krTQS4g>
    <xmx:xBSOakl1skB_fm3CwXGqYVO6a3hH8N9gitpXezS6tjTuzWm8usOD5g>
    <xmx:xBSOajY1YKFt_OEFUXpzGZB6g63yIXUppOQglZ3QKdtQ_PmRmTGkDDJL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 18:18:41 -0400 (EDT)
Date: Tue, 25 Aug 2026 16:18:39 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v4 04/27] cxl: Establish media readiness in
 cxl_mem_probe()
Message-ID: <20260825161839.2cb3a6c7@shazbot.org>
In-Reply-To: <20260813093631.2288172-5-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-5-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:08 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> media_ready was only ever set by cxl_pci, in advance of registering a
> memdev and with CXL Memory Device register assumptions. A consumer that
> creates a memdev without cxl_pci, such as a mailbox-less Type-2
> accelerator brought up through devm_cxl_probe_mem(), therefore handed
> cxl_mem a device with media_ready still false, and cxl_mem_probe()
> rejected it with -EBUSY. __devm_cxl_add_memdev() turns that into -ENXIO
> back to the caller and the bind fails.
> 
> Move the readiness wait into cxl_mem_probe() so every memdev consumer
> gets a ready resource regardless of how the memdev was created. When
> media_ready is not already set, wait on the device's DVSEC
> Mem_Info_Valid and Mem_Active bits and mark it ready. cxl_pci keeps
> setting media_ready before it registers its memdev, so that path skips
> the wait.
> 
> The CXL Memory Device register group is optional and many Type-2 devices
> do not implement it, so cxl_await_media_ready() must not read the Memdev
> Status register unless the group is mapped. Reading regs.memdev on a
> device that lacks it would fault. Gate that read on regs.memdev; the
> DVSEC bits already prove readiness for such devices.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 15 +++++++++++----
>  drivers/cxl/mem.c      |  9 +++++++--
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 08d4c955137d..9b372d5a1aa4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -151,7 +151,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	int rc, i, hdm_count;
> -	u64 md_status;
>  	u16 cap;
>  
>  	rc = pci_read_config_word(pdev,
> @@ -172,9 +171,17 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  			return rc;
>  	}
>  
> -	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -	if (!CXLMDEV_READY(md_status))
> -		return -EIO;
> +	/*
> +	 * It is possible some Type-2 devices (CXL_DEVTYPE_DEVMEM) do not
> +	 * implement regs.memdev; only consult the Memdev Status register when
> +	 * the group is actually present.
> +	 */
> +	if (cxlds->regs.memdev) {
> +		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +		if (!CXLMDEV_READY(md_status))
> +			return -EIO;
> +	}
>  
>  	return 0;
>  }

This looks like it should be two separate patches.  The change below
depends on the above, but the above change stands on its own.

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..9c6e99b9124c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -105,8 +105,13 @@ static int cxl_mem_probe(struct device *dev)
>  	struct dentry *dentry;
>  	int rc;
>  
> -	if (!cxlds->media_ready)
> -		return -EBUSY;
> +	if (!cxlds->media_ready) {
> +		rc = cxl_await_media_ready(cxlds);
> +		if (rc)
> +			return rc;
> +		cxlds->media_ready = true;
> +		dev_dbg(dev, "CXL media ready\n");
> +	}
>  
>  	/*
>  	 * Someone is trying to reattach this device after it lost its port

LLM review is noting a plausible behavioral change here; if there is an
actual media issue, it seems it's flagged in cxl_pci_probe() by leaving
cxlds.media_ready false.  That path can then go on to find memory
devices, add a CXL_DEVICE_MEMORY_EXPANDER, and via the .probe callback
reach cxl_mem_probe() and wait another timeout delay here for the same
media issue.

Should the mailbox-less path test and set media_ready before adding the
CXL_DEVICE_MEMORY_EXPANDER and getting to this .probe callback, making
it consistently tested upstream of this function?  Thanks,

Alex

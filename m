Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3E3D649C;
	Tue, 25 Aug 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693182; cv=none; b=Hso1R/zMB2h2V+6HsJLlMyVn+d5v0xRmXAcZw2bKyKo7CHlrPf6BZqaBzehLnLoGkDUclHOhEgglDR3CCOd2nkfFMoJBg4jFRYdZhx5hOtTKnO67g5ExA6K9fV2JSuPwwvqq7ww+juPhzLYSqXhkgCpFTtX9dj9pJ7lQZM/aw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693182; c=relaxed/simple;
	bh=fyxOKeBBeK3d6FRXyXiUs1QmsIWUVKH+V6Vz4D3pMZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwafAGmeBJQ7YCAnEOMMBU1A+5OEkP0RVlODiU7YEmK94AMNxvPAOsBKVBzpaXRnxydCWXNU++yaCvXn3B0ys/1rAC5+xhLPDBYA4HWOVbnNlkWlyGrlNSa8wvwZs9wsPmHHcpjMI7XRZsYZGjMoahyxwNp+lZqShzmUylUcuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=gnuBbRks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+TRJWUF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="gnuBbRks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+TRJWUF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A882B1400028;
	Tue, 25 Aug 2026 17:26:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787693177;
	 x=1787779577; bh=TI3LYYdNPFkkgbQYpNaHoiAiGm3EHWu4t1KyT0USaQg=; b=
	gnuBbRksEM4IVJKkNrBcekDrkwduiHEBy59k85/ZIMDNBoaXr17k7Hutww0R6KEB
	bEPfdMJkrQIAqXwMm9KxAbamu4TJq11ir5aToXac1QgF3E9kjN2b643whh5u4o4v
	kOE1E6fKqxODFreGRtS2jrDFy+UQ4Uvg1UuT46O3g1+j5tqN14bHo/Z5HvXpKPHX
	XmperEbm2KPqVAFa765egvNzDfTxllWhPxAodO+bLUZ0Ss/oxzu4BNvvXGMVgdRy
	+DC0CBkiZubnlnFXQiyNVulj2VB2jUrCZFRjQ0DS7p5L1uiUYeSh4l6sGttqla2g
	6YJVjQjTJOreJwqlgL3JcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787693177; x=
	1787779577; bh=TI3LYYdNPFkkgbQYpNaHoiAiGm3EHWu4t1KyT0USaQg=; b=B
	+TRJWUFMr7kQhUHWTf/KZh914+bi6aFlCMFomNTFT2HBbBUAlhrwxbw8bBatnTyW
	Y9Ut1551d2miN2PdGgBbJbfYmjM4tpcHlMPOmt/TIJ3apPg8g4KUOCHtYbojv6Kz
	78ISFzmd30iT5YB5BogrWwQnfgUG0xXErIaGgNlx5wac32gjLrkCzv58vRtKNShw
	g855wpA+6ttHk4f6qx5hDSVky1cufwqukKyIBfASKQUcbJnZbFjfXoWToW/xDXz3
	uK/UXO4tTiYEzdm3SQEiMkp7PvSRu0c4V8kjaHpkEC7dMsgHSZ+sHPVd8EDJXI39
	IUpaeSKqwTBQh9xcz8/XQ==
X-ME-Sender: <xms:eQiOarI-bJ04mimDcA6hHrNVB_ySrKFWcaQ9ohaGh0BFk6FDlo-QmQ>
    <xme:eQiOasxYIr32WkH9UDsd79wHHmo5h9Pe_kMou3e4O3OPvI_ZRpOa5MH43wY0uhxwq
    ijiQyPWGufcC9Ze139FKxvMUZd_yoNguVd-cFeSGFPo6dvusuSJ5_w>
X-ME-Received: <xmr:eQiOarGor_aqez3tlDVXWfoT2b42s6KnP10PKlNVPaDPMweFd96IOi8fSaeIIg>
X-ME-Proxy-Cause: dmFkZTFDCnzeDWsxERS9FkI6DBSsnwLXGNSWypdSO0vpo1L1cZ8qp7QTaKQyexIgzTaE7y
    22Sl/fGmqHlnzDyaWz6mLYf7N1NKWsNS1yWa8h+RMNhmImKeztb0335u58TuenXGTYAuIM
    EzZrRtRJnbOGSdwAORlEh7eGMi4Q/uY4YeY3hmJjacATb6krK+zMebxYE90E5xPiDyVxe2
    lpo4XOgv+3AUMv3dwuNSn9S72Z8pgfr4gHzcI3ve+tXB+i4MgABrLXN/b0/D7mGtvP0vYc
    sQVr8Fby7N+48sEUHUgf4xT3oIUTzbVCPMJfPtVzAI7j1tNMyPPcSuiYenxt6LN++NWQh7
    IQS3kipUKf2kie4KllVx84HoEoBbHWbfV30SOiEFizWDgc1M0Ki1sDoGzMgDPiEGcW5CCP
    KzhSgd4oap2TXH3vwCdby1qDPEMXf3MWws1Om9gFLvjxrcEB7jqAh2fQtpRPXEhWOFQ70T
    7p7Hpcnnx6WUhMB00f4+rkEt65qC7BTtfuI+8u55y6+YGIltZVmq6m92LQ1d87gWe8q1qv
    LDCTpAC9qcEq8uHJlBp/CEFqwm7WkcrPOAd5Kkx44Ul7MGpzbKoQFhN+AsMiAMYbCaO/VM
    4M0Nvop9e8XtF/T+lvuQISTXgw3ED4ysLjLbtR8DeqPjk92R1Z1HPq7ITAMw
X-ME-Proxy: <xmx:eQiOasmlra1DxmP3CFzeMZFlzubXYtJyp_tE9yzs5jcZ-RLKLbjrsg>
    <xmx:eQiOaqHkFSOihEFH0PRkk1nhlBjxY9tQBY8807526HcEDl3zc5XydA>
    <xmx:eQiOanx_tuHgMdgbSNNzDqyVxBPZWcLXyXR_e4sMA_nk_PCTPiY6dw>
    <xmx:eQiOarb6ayr9RwBBqXNYhTVNKVvuiXmGQKxfiIWNmdQRvvvXj5OW8g>
    <xmx:eQiOaklv75D2NAx4jFmSn2PQW2pK53_lavG9FGwr_V87iKZPc42dCb_L>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 17:26:14 -0400 (EDT)
Date: Tue, 25 Aug 2026 15:26:12 -0600
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
Subject: Re: [PATCH v4 02/27] cxl/regs: Skip sub-block region request for
 BAR-owning drivers
Message-ID: <20260825152612.5b8452f7@shazbot.org>
In-Reply-To: <20260813093631.2288172-3-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-3-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:06 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> cxl_map_component_regs() claims each mapped sub-block with
> devm_request_mem_region(). A driver that owns the whole component
> register BAR, such as vfio-cxl, has already claimed the full BAR, so
> the per-sub-block claim collides and the mapping fails.
> 
> Add a bar_owned parameter to cxl_pci_setup_regs() and record it in
> skip_sub_bar_request on the register map. When set, cxl-core maps the
> sub-block without requesting the region and leaves ownership with the
> upper driver. cxl_pci passes false and keeps its existing claim,
> preserving /dev/mem tooling access to the rest of the component space.

The bool arg itself is an undesirable shape, but then threading it
through @bar_owned to @skip_sub_bar_request to @request is difficult to
follow with limited utility.

What if instead cxl allowed drivers to register the resources they've
already requested into the reg_map, ex:

int cxl_reg_map_add_owned_resource(struct cxl_register_map *reg_map,
				   struct resource *res)

Then before cxl does any devm_request_mem_region() calls it creates a
temporary struct resource for the range it wants to request and
compares it to the resources the driver already reported as owned via
resource_contains()?

I'm picking reg_map vs cxlds because it seems easier to thread through
to where we need it.  In this flow, devm_cxl_iomap_block() could be
split into devm_cxl_request_block() and devm_cxl_ioremap_block(), where
cxl_map_component_regs() would conditionally call the former when
resource_contains() finds no matches for driver owned resources, and
the latter is called unconditionally.  devm_cxl_iomap_block() could
remain as the unconditional user of both.  Thanks,

Alex

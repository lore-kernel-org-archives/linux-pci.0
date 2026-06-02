Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8F1FC0EA;
	Tue,  2 Jun 2026 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441735; cv=none; b=rkbzKajrZKHR1limK2QR6JAWXK22bbXUDhyqtVNb3szAeYTZowcgtNeQnDdd1dZ9zmn0HpZnL+xQHkWHHRPpZD1TfM9renyTRErniuhWFyrpoJt8jocvaTE4nJ7a63ZU8cHQzjOTVGjhXRB4QG0EqO0Rsp5oDvjz6lSNyskV5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441735; c=relaxed/simple;
	bh=QBHnnineqjThiMLhY+nr1MKw+5hXNJMMrTVbAQfm/ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMDsDZFD+XXjO65Fnu7FOKjeIZkI6eNRuBYIIDuc+DMEWlnZw3/mNJ0vJDMUAImCXtHutvM0ZN0iBQSvIQuCxLWLonqK5gxWmdgplYAVLDuYjYZakVT2AhSXbJEc5Xvj1AFYWva1Dvy/Y2rVDTUwJm208RaaIW/blfEQ0a3JWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=U710U8OH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5swia51; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="U710U8OH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5swia51"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 722BD1D00097;
	Tue,  2 Jun 2026 19:08:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 19:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780441731;
	 x=1780528131; bh=hHE7BDsIE+Zyxz7NbvGL2s+sSkSVVhwfU+vpeKVXfVk=; b=
	U710U8OHYHaBQkZfVnzbpAmOJk5srW+5q8lwA1ZQA8IQ2nYGX4s7VwoOph/O1QSO
	KE0mq25YCRKat3J6HuT885iweJJoit91sPlHe1v4PSwQuAjMINTZ4YaU1Ix0YJOQ
	QUeI2DoNK5/8sHQQW0aEuqktRBUNyh/bY0RKKSsvwLx4zSViJU9IKcWc2ZqYqn9h
	XWtUCEfi439W13G+kM30KSdhfD21QtioFrIhYjxsUohoxoMrQuscDFJlwwn+m3VB
	HBlMBpXY78anzFRiSFe01pJmc+8BeqZvfesnAKzOSHEGspTDTnqx7R3qml0KkCS0
	SX7Zn+WxM+1TlI+JhmZk2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780441731; x=
	1780528131; bh=hHE7BDsIE+Zyxz7NbvGL2s+sSkSVVhwfU+vpeKVXfVk=; b=J
	5swia51l52N7meeUmwRFvRYWfIkuxL30Q01bb24DyKp+kxHNgpTgZWI0nmx8BxAg
	IZy5P4KLt0G2rCfgmPXcoNbumd57XJF4MY5xryTuUhXTJUzLCO4DFtx7MrEbxnao
	3znTsL5F5Nd2Bnri7e1MMYmC/YZ7yV9wTyolpcXR8dRXvsD0h4nIB7sk+iTWi3Yr
	ikVAC5TUCwJ9PN265EVNazx51cjPqz67foPS7IQOMb5Brl7VnbRqIPGROK/KVLc0
	9S1v6IAwCG1RZkYxSiNviBY+OsvNHn15egtOFk5pvXXkG15YDM68uoD8Dx8I/oMf
	MT8Xu9vXlV1fTAWLPqbcw==
X-ME-Sender: <xms:gmIfavnv0jtj091jA4q0O9kOWAxPjYaisYUTqcxMIaMC-aGSwMEQ4g>
    <xme:gmIfakYgpFb-iFgUG5EXHvbApsl02v4vgxBldXEU57hmfYHGN0o8eirORSKv7FgvF
    hGnXtcvqBG82hP_neUv0SiWt3DGYaR8JmBbcaReLJ1Dw5LWPaMMew>
X-ME-Received: <xmr:gmIfak448xMed22c78axF4MoI_KZJHF1AbmEMJnBiI9hv2IMk2CO0iHt0Wo>
X-ME-Proxy-Cause: dmFkZTEpOa9wz75B8Q/gwxysz4tZUzjPJA9ylxY7solEg/vaMA+yel0FzfMN36Vz05Tmox
    LCNY3F80k0Qsk2YLJNMHbD/kf9ISKAFulUycB+8lHvyXvYvQi4V3xAKy5tikOR3G8MRGBW
    Tfu1z5J6kq3p05/gQG8q5w4ZoxM1nPmYEqYvuJIIF2guQtE5lx2hVfI/5rQQmXScz0NG5m
    7UmUSvqXX/24UeSAQCmvc6j59iw5iYs0T6buGvrenoy4o4Tpq5xPDouR/ZiqGShcYfTwW9
    957COyw/2GD1e0NClqd551l+NRyHMq9x62ByDKjuWr6rk2FjPzPeD4LFqwyKZegGFDcJCY
    ZNyceiy8lslzTiNPZYQI00wQhOfxXS4KeoqWVrkyQJrN4ZWQCfXwRaY51MD/uEW+gft0DB
    oNeHknzkYjqfRasqjOaZJprkw5hau2cxFln1OvbJ0dxIBYio0uIPSPaFJJCTZrc/9jN6CF
    yJtdFkIsMSMAV7vYcXxURBccUBx1Wl028Ovyl5vA14xcHCEyPKUbnOqPVlcAfMQrA10bE4
    Qw0Tg5Ij3RpChwLMTws6I6KRBfnU5x2r6p+rXpED6s5/XjX9TfFTBsx5WCwcrch260/+l5
    ntR2L/vmfAmMNEIYwN/9fbhvscb98gbHnCHTIlXY75GQRwWh96YDMvaIQN5w
X-ME-Proxy: <xmx:gmIfauDeC7rMon7-Eru4isTxY2iLIzB26sc-8Gd-i13E5bIu1BjHVQ>
    <xmx:gmIfai8zZGFxdQIybsuknycQqQu8jYaeoMiFcZANvZe5GgH5SF68dg>
    <xmx:gmIfapGDZMGv_oR4tdXzgE0QYOch-h801r0eu-9p1ie7eLHBOzrrjg>
    <xmx:gmIfakRsnCoYWJ74Y4jDFt02Qu3aQx92W4D-iyJnX2ni6H8JKJrC9w>
    <xmx:g2IfanJneUk20gRvRsYL08u8EGpquxINFTZtaabKAWBeyTk-qzdAVh4D>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 19:08:49 -0400 (EDT)
Date: Tue, 2 Jun 2026 17:08:47 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260602170847.75bd159d@shazbot.org>
In-Reply-To: <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
	<20260601095840.3aaaa508@shazbot.org>
	<59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 22:46:13 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
> On 6/1/2026 11:58 PM, Alex Williamson wrote:
> > 
> > 
> >  - Patch 2/ sets tph_cap to zero if TPH cannot be enabled, but this is
> >    never propagated to vfio-pci to drop the TPH capability from the
> >    capability chain.
> > 
> >  - Patch 3/ exposing the enum to callers is a bit ugly, maybe we should
> >    retain pci_enable_tph() as the "auto" wrapper, resulting in no
> >    change to existing users, and add _ext and _std wrappers.
> > 
> >  - Patch 4/ same, multiple wrappers keeps the "auto" api cleaner.  Also
> >    note that auto is broken before TPH is enabled when tph_req_type is
> >    zero.
> > 
> >  - Patch 6/:
> >    - mutex_init/destroy belong in vfio_pci_core_init_dev/release_dev()
> >    - Re-order to avoid forward declarations.
> >    - vfio_check_feature() does not require declaring PROBE as a
> >      supported op.
> >    - pcie_tph_set_st_entry() can write to MMIO space without testing
> >      for or enabling device memory or power state.
> >    - tph_init allocates shadow table regardless of opt-in for tph
> >      support.
> >    - Redundant tests for count/index in feature function.
> >    - Duplicate memcpy/kfree in feature function.
> > 
> >  - Patch 7/:
> >    - Unclear why it's vfio-pci's responsibility to provide this
> >      translation interface.
> >    - PROBE is unnecessary for vfio_check_feature().
> >    - Array size conversion is strange.
> > 
> >  - Patch 8/:
> >    - default config read handles emulated bits.  Clear the bit if
> >      necessary in vconfig, use p_setd() to mark PCI_TPH_CAP_EXT_TPH
> >      virtualized, read-only.
> >    - Follow examples like vfio_pm_config_write, vfio_vpd_config_write,
> >      vfio_exp_config_write, etc.  Set the virtualized and writable
> >      bits, perform default config write, evaluate if anything was
> >      enabled, effect the change in hardware via kernel APIs.
> >    - pcie_disable_tph() happens after the restore state is recorded.
> >    - TPH capability becomes read/write, an ABI change to the user, with
> >      only a host-based opt-in.  Seems like the userspace driver also
> >      needs to opt-in to the ABI change.
> >    - Memory enable not assured for pcie_tph_set_st_entry().
> >    - Sashiko notes there are existing hazards in the tph_enabled
> >      storage unit relative to multiple bitfields that can be updated
> >      concurrently.  The problem is worse with this exposed through
> >      vfio-pci.  
> 
> Thanks for review, all your comments are resolved in v15:

Not everything.  At a glance I can see that v15 is still pushing for
vfio-pci to provide the interface to translate CPU IDs to steering
tags, despite my push back above that it doesn't seem within vfio-pci's
scope to provide a CPU ID -> ST interface.

The host-only opt-in issue above also doesn't appear to be addressed or
rebutted.

Typically v15 would be an indication that a series is coming to
maturity, but with the quick cadence and lack of discussion throughout
this development, I'm not even sure we've arrived at a proper uAPI for
this feature.  Thanks,

Alex

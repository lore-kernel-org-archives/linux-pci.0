Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97E3BE644;
	Wed, 17 Jun 2026 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682244; cv=none; b=TQA6jkIARNAc0f3cOscyQZYwAKCdYpsrO27BPekOo9HY8axe6pdgl7kWq0hAkrAJwjWDqXFS8ZTjbe4dd87RwzFCZxcd7TYpW1gzF6w9U8HlkGiLOgHerJgWC+e1hUBgioKoEFh+ilv7feVPAWKsTa+YCzKaX0sA8hxEYwcPdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682244; c=relaxed/simple;
	bh=/EdeG20kEJzpkiORgoCE63qhp/Du+TBSDBWc2PyQuis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g19+aCRvVsKP2nrj3QBcm5UJw1HBblp6XBjVE8FW12/uYxAmy6uzw6SqpPRuakPm9wQLTowDlrmIdGuBBWBURIL2SGyNm6GS3lGbfWRskC9Zt7aRLc3rSbn8vGFhwmgaIuoqwj/QeECRj/yHmfah1OmDD4+yDoTv2iKOGlh4sUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOi7Qdfk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOi7Qdfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781682243; x=1813218243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/EdeG20kEJzpkiORgoCE63qhp/Du+TBSDBWc2PyQuis=;
  b=IOi7QdfkFMhwmkSPTxmWLnlnI2gnA7j3TWssqjRuRrohbOdnd+fv1LSM
   OlcXSBpz1o+P1zAjIcIkoFi3NWvrCXBq/ZOXY9Gph2b25cBv1o/hteh76
   y1pL3NUtLvYda9+LTS624/YyqP4AVHuf3GW8wd4ULz/+Z/GNdON+W4mnh
   oPXi9pHAXM2k9/Y7Tq6hl5FZpRUJr6VunGy1opTtYPiBXCUYRNdMpmWgY
   Yn2mvB28fSWzWeGp2XuU+kZ9/fQ8aQ6CRZXdrshQE7uXQx1kE3Yl2DSoA
   qOA+bRyRqc15fLrZtJNCJ/2OWYvgjEvNzUSietgxwYRCBG3QDvYZVEbOz
   Q==;
X-CSE-ConnectionGUID: RawRIFvpThqaq4PH1zding==
X-CSE-MsgGUID: GRLQX7yERxym/5cSl+JAFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93133623"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93133623"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:44:03 -0700
X-CSE-ConnectionGUID: QS8us01VRcSTU+PBtapD8g==
X-CSE-MsgGUID: heGMeiy3SveOyifxnzjMCg==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:59 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: Junjie Cao <junjie.cao@intel.com>,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org,
	cpgs@samsung.com,
	arun.george@samsung.com,
	vikash.k5@samsung.com,
	s.neeraj@samsung.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	gost.dev@samsung.com
Subject: Re: [RFC 7/8] hw/pci: hw/cxl: Wire SVC initialization into port realize functions.
Date: Wed, 17 Jun 2026 23:45:19 +0800
Message-ID: <20260617154521.520191-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609105836.3702787-8-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com> <20260609105836.3702787-8-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Tue,  9 Jun 2026 16:28:35 +0530, Shrihari E S wrote:
> +    pcie_config_uio_svc(d, errp);
>      pcie_cap_arifwd_init(d);
>      pcie_cap_deverr_init(d);
>      pcie_cap_slot_init(d, s);

In rp_realize() (and the two xio3130 ports) pcie_config_uio_svc() runs
before pcie_aer_init().  pcie_svc_cap_init() falls back to offset 0x100
when no extended capability exists yet, so SVC is placed at 0x100 at
this point -- and then pcie_aer_init() puts AER at the same 0x100 and
overwrites it, while dev->exp.svc_cap still points there.

The visible effect is that "-device pcie-root-port,x-uio-svc=on" comes
up with no SVC capability in the extended config space (the chain is
just AER -> ACS), and no error is reported, so the request is silently
dropped.  I reproduced this by walking the extended capability list of
the root port over ECAM: SVC (0x35) never appears, even though the
property was set.

> +    rc = pcie_config_uio_svc(pci_dev, errp);
> +    if (p->flitmode && rc >= 0) {
> +        crp->uio_capable = true;
> +    }

On cxl-rp this runs a second time: cxl_rp_realize() first calls the
parent rp_realize() (which already calls pcie_config_uio_svc() per the
hunk above) and then calls it again directly.  The first call collides
with AER at 0x100 as above; the second runs after the extended caps
exist, so SVC ends up correctly at 0x200.  So cxl-rp happens to work,
but via a double init.

Just moving the call to after pcie_aer_init() isn't quite enough on
its own: the CXL ports (cxl-rp/usp/dsp) build their DVSECs at fixed
offsets and then add SVC themselves at the end, so if the shared
parent rp_realize() also adds SVC before those DVSECs are built, the
cxl-rp ends up with its DVSECs off the chain.

What worked for me was to move the SVC call after the ECAP inits in
the pure-PCIe paths and skip it in the parent when the device is CXL,
letting the CXL realize functions keep adding it last as they already
do:

  - rp_realize(): move pcie_config_uio_svc() to after pcie_acs_init(),
    guarded by if (!pci_is_cxl(d)) so cxl-rp's own call (which runs
    after build_dvsecs()) remains the one that places SVC.
  - xio3130_upstream/downstream realize(): move the call to after
    pcie_aer_init().
  - cxl-rp/usp/dsp: unchanged, they already add it last.

With that, plain pcie-root-port, the xio3130 switch ports and the CXL
ports all come up with SVC at 0x200, and cxl-rp keeps its four DVSECs.

One thing to note is that this only gets the capability enumerated --
I haven't verified the SVC behaviour beyond that.  Looking at
pcie_svc_cap_write_config()/pcie_svc_apply_gating(), writing the SVC
Enable bit just copies ctrl/status into the shadow struct; no VC
Resource Status bit (the per-VC negotiation bit, SVC_VC_NEGO) is ever
set, and the SVC Status register stays zero.  So a guest that enables
SVC and polls for negotiation wouldn't see anything change.  If the
data-plane series on top is expected to drive that, fine -- I just
wanted to flag that as things stand the enable is observationally a
no-op, in case a driver is expected to key off it.

Many thanks,
Junjie

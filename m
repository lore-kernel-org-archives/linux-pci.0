Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A72C08BB;
	Sun, 30 Aug 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074504; cv=none; b=hedcq1qX1CeR46lWTzcvVSOVSHypWnyz7H2Wke+ZUo9jmt+1IcuQf7ea6Jus3OmIKVDmHnFkOxsCjzkS7k/+0aFMybK11YiW9kkVxXMUHFMcKnB7eqdEQmFHIHgUj9STjS8S9f6l2GbtS19GrvHqOwfiogMVYW+vNvxE6PSLhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074504; c=relaxed/simple;
	bh=p1aIId6OF51IkNNctX/PRW+eNkg+BLyFrTHN13rl6Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e835aD7lsuy5lt18+F3oRoNH/pu9HCV6j0Eiu8qwX6uzREFCCmUSadppehbTTUGeMtk5YPxdr6/rLZ6BGN2S5IGgxy7TbiI26lIqLPij5Ei7hD3PS8skpAA1IvZUtDgsm5SHGJL43FYzZ/eD379g/RpqxWRhgFltCAiyIAHTvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmHOJ4aM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmHOJ4aM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074503; x=1819610503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1aIId6OF51IkNNctX/PRW+eNkg+BLyFrTHN13rl6Qc=;
  b=PmHOJ4aMV/3hskDv6Lg10sSl9QyfRs1cggxyPvMY2yzGswPm3vAMKni6
   12Tb2pcULC/mCFWp7bqs0PxIcTczD73Qv76IfsTO3YZOkUbybKj09Q5Xg
   zynCHZw7BAmsNDk8vUTU4aSNTwUYkZ+Ip3fEXMKallGuEAnj0g6YNNFSr
   3lH34ksCRbDi2IuvYkP1jTDBZ9hhHY60reULSSfOVzczCfjRBI/dRRPlQ
   BUlIwi5vdyEkZUC5LbcyKPVcWGMIkVwi7Vb6GlRYZeYlXWW/SvqNJ5URI
   n1wmN9rzteP5F9iDfXsl2+AjhW3ETdeltt1kdjr49nvyXFknzKvU5TIWX
   g==;
X-CSE-ConnectionGUID: PQoJ7RaKTNSBK5E+jXOiNQ==
X-CSE-MsgGUID: +kB8W/chRhObGFI9wQvLKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648922"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="87648922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:21:42 -0700
X-CSE-ConnectionGUID: q7DV/ze/QZKouI+R5fR6uw==
X-CSE-MsgGUID: 82SegnomR8KdHAghDREvOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="266710316"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:21:39 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	dave@stgolabs.net,
	arun.george@samsung.com,
	dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com,
	vikash.k5@samsung.com,
	cpgs@samsung.com,
	gost.dev@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [RFC V2 05/10] hw/cxl: Wire UIO capability into HDM decoder and DVSEC registers
Date: Sun, 30 Aug 2026 15:21:18 +0800
Message-ID: <20260830072118.399487-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
References: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:05 +0530, Shrihari E S wrote:
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     UIO_DECODER_COUNT,
> +                     (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT
> +                     || type == CXL2_ROOT_PORT) && uio ? decoder_count : 0);

The always-true expression from v1 is a real type test now, but UIO
Capable Decoder Count uses the same encoding as Decoder Count -- CXL
3.2 8.2.4.20.1: "See the Decoder Count field in this register for
enumeration" -- so writing decoder_count raw advertises 4h = 8 UIO
decoders while Decoder Count reads 2h = 4.  I read the register back on
a cxl-rp: 0x00042312, bits[3:0] = 2h but bits[19:16] = 4h.
cxl_decoder_count_enc() would line the two up.  The same field
description also marks it reserved for CXL.mem devices ("not permitted
to limit the number of UIO-capable HDM decoders"), so CXL2_TYPE3_DEVICE
should drop out of the count expression.

On the type list itself: 8.2.4.20.1 enumerates UIO Capable for CXL.mem
devices, USPs and CXL Host Bridges, the Host Bridge case being the one
that means "all the root ports within this Host Bridge are capable of
routing UIO requests".  This sets it per root port instead, and
pci_expander_bridge.c passes uio=false for CXL2_RC unconditionally, so
the host bridge never advertises it.  On v1 I said a root port may well
be intended, going off crp->uio_capable in the SVC wiring, but the
enumeration above doesn't list one.  Is the root port the intended
carrier?

> +        if (uio) {
> +            write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] |=
> +                R_CXL_HDM_DECODER0_CTRL_UIO_MASK |
> +                R_CXL_HDM_DECODER0_CTRL_UIG_MASK |
> +                R_CXL_HDM_DECODER0_CTRL_UIW_MASK;
> +        }

The if (uio) block adds UIG and UIW to the write mask for every type,
type3 included.  8.2.4.20.7 makes both "RWL for a switch and a Host
Bridge if the UIO Capable bit ... is set" and then "reserved for
CXL.mem devices."  I wrote 0x00ff0000 to decoder 0's Control register
on an x-uio=on type3 and read it straight back; the same write on a
type3 without x-uio reads back 0.  Gating UIG/UIW on the port types,
and leaving UIO alone, would match the table.

Many thanks,
Junjie

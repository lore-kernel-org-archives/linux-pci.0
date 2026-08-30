Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADD7082D;
	Sun, 30 Aug 2026 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074453; cv=none; b=fgtv1HYeB7hsaMQLSSf4iiC5sno9GvaiC/AzOhh3BEqJkCJAAOPEqImSdeSuDdL4Wyc3NrLaHWnQ7oLUDpN5h7sUtrLSmDrdvQUhPvaL4ezJ8cXqkp0zx68d3ik7TmkTCKVTkmbt57KdVEvEhRP0tKfZHkErN5ft2lDrM0WNOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074453; c=relaxed/simple;
	bh=LdTtOWeM2IupHOESHTlR4fJuKJIE7l5dPUGdYK1waLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS3+6vIETrS4QUYJbh8yAV4Jh2lWEPQYG6/onefPjwk6T8yBivtASg5yuGrskMk3mw9JzrJhGRTN4IrLrLciYwORBwY8+t3mVLRuPNPQN00iSsT1MA7+AjnXE/SPXA3FEbe01zOqmV7pwBKL8OlcQV5J1GShlIqlS+Pk07zY0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DglQnyFO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DglQnyFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074451; x=1819610451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdTtOWeM2IupHOESHTlR4fJuKJIE7l5dPUGdYK1waLI=;
  b=DglQnyFO1jAuZyn9XnPEqUoFni6SManN8ILWdkiYZtPEX6QLzCu5WgEV
   pisUqOSiF/swxwIz9Ybqk39BLhbQhPta16YaBB+tDJ+gwOPBxYp2jQ2kN
   AfVujl/djOQ4WQ9v8RwHfU97CuCQi+Unc2d8c0pQhWj2BO1ZNSf0fwd4w
   CD+yRzZM+oxrRqimh0Ijd3i1dYPldnHRaplvfnDGuAL5egooBWR39uWuX
   rAsf7pr0Q9EbAKkdNC657J97Pdy4XTw7glXEBdUI2Ewm+Uu/bUKN97ya5
   U5m500BRUo3VQRMbMMvn8QpBguKM9WH6Wn8j560sy1bA5ytKjCPVp2QCD
   A==;
X-CSE-ConnectionGUID: kj2SE+SBSM6LYUt3gUCfcg==
X-CSE-MsgGUID: esMkpVWQStSF2nP8dxw5kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="105890980"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="105890980"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:20:51 -0700
X-CSE-ConnectionGUID: /DlKDPiXRMy5CWLkvaUrrw==
X-CSE-MsgGUID: F28vXvpvRlGJOowH3bxy+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="292017711"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:20:48 -0700
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
Subject: Re: [RFC V2 02/10] hw/pci: Move 'x-256b-flit' property from cxl_root_port to pcie_root_port.
Date: Sun, 30 Aug 2026 15:20:20 +0800
Message-ID: <20260830072020.399442-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <111374580.41787732102942.JavaMail.epsvc@epcpadp1new>
References: <111374580.41787732102942.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:02 +0530, Shrihari E S wrote:
> @@ -152,6 +152,7 @@ static const Property rp_props[] = {
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
>  };

This moves the default=true along with the property, so it now applies
to every derived root port (pcie-root-port, ioh3420, pnv-phb-root-port,
aspeed.pcie-root-port), not just cxl-rp.  On an empty port the LNKSTA2
flit status bit flips at this patch alone -- pcie_cap_fill_slot_lnk()
consumes flitmode, and pcie_sync_bridge_lnk() only overwrites it once a
child is plugged -- so "does not impact any existing behavior" doesn't
cover the derived ports; with patch 6's pcie_cap_fill_lnk() additions
the ports also come up with Flit Mode Supported (Flags bit 15) and
LNKCTL bit 13 guest-writable.  I checked "-device pcie-root-port" and
"-device ioh3420" on q35 with the series applied: the Express Flags
read 0x8142 on both; before the series the property didn't exist on
these devices and bit 15 stayed 0.

That's a guest-visible config space change on non-CXL machines with no
compat handling.  Migration already breaks at this patch -- pc-q35-9.2
at both ends, plain "-device pcie-root-port", a build at the series
base on the source and one at 2/10 on the destination:

  get_pci_config_device: Bad config data: i=0x87 read: 0 device: 4 cmask: ff ...
  load of migration failed: ... '0000:00:03.0/pcie-root-port'

0x87 is the high byte of PCI_EXP_LNKSTA2; with the whole series on the
destination the first mismatch comes earlier, at 0x57, PCI_EXP_FLAGS.
Fresh q35 guests see different hardware too.  Was extending the default
beyond cxl-rp intended?  If yes, it needs hw_compat entries for older
machine types.  If not, defaulting to off here and setting flitmode
in a cxl-rp instance_init would preserve current behaviour for
non-CXL ports: a second DEFINE_PROP in a subclass asserts on the
duplicate name, and instance_init still runs before qdev applies
globals, so -global and hw_compat keep working.

Many thanks,
Junjie

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C32246782
	for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784982601; cv=none; b=mDkaOnxgCJJCZKP/SQKuAaoE5BgT6E0l00Kdx063TvZV86lhc6wOBQsxgOJbCXZy1q11RWiasT/hltf5yziAoBGxNNlOeMFeRFEqQ3FCd9lXoofu4AZd3JqUgyo1LuFRHqUztCkXwMom0nAqIHh0WLmbjcugZdFMkBlfFUqarlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784982601; c=relaxed/simple;
	bh=S7n41pOvYX+1Yhkwcm5Ywpght7bTGclmaljhJDz9syw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sd7AQHsFg5LthUjpVDQUGHuQM17qNRecy8yqYN5ReCiWOWb2nhlZCmUjVXZu3aUB1Jjvd5tbnHAQsjfgB9XOISV1iQx9eaM/xqJWoh3hy4ULqweV+0C5StU25JCiPN/WfvwqvrX0KNJ8iJAPO5UTSfA9CIu40TayDjr2lfBwC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hs12EoTc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hs12EoTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784982598; x=1816518598;
  h=date:from:to:cc:subject:message-id;
  bh=S7n41pOvYX+1Yhkwcm5Ywpght7bTGclmaljhJDz9syw=;
  b=hs12EoTc8ICEvcNr/x64e8y67v6b5R9eoKuZxh65XEXBBJsy25nhmjMp
   pJo+M2BBeidLrsw0pG88c/YsoiuqgKJoAcKRSmh7v8GMkXwnIXmpyTR4x
   Kl4Hx58369XCrHPeiZ8djdpEEOv5/KlLAeIOMWsj48jsKjH5y87k/9EH0
   CkQEOXLwdiHJuoSETdjtS+Xa+iD7Au9k/LvnU++hODqt4wcd+bGVIo8St
   9Yc63Di+aDhcz6KcviSSkNbAQZnoPLLZQlKsH9Bp7IjhNQsASFpT5meEj
   Fts3jyFtyjEwl8Zll4FWswMQTnAaTANOHeFVarU5YYLbW4V5AWhNzNK1m
   w==;
X-CSE-ConnectionGUID: tvuJhp+ISKOAVpVc1mvbBw==
X-CSE-MsgGUID: 8SE9GNS3Q4qFjfMm7WB69Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="84752360"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="84752360"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 05:29:57 -0700
X-CSE-ConnectionGUID: B36Vbys9SEGw2qaDidg2aQ==
X-CSE-MsgGUID: L3JXZSDRRX6lJDiueRUAtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="252624789"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Jul 2026 05:29:57 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnbVq-00000000bg6-1dd4;
	Sat, 25 Jul 2026 12:29:54 +0000
Date: Sat, 25 Jul 2026 20:28:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 90c4d88be15e11c1e922ef93e611b5e28103e37b
Message-ID: <202607252029.w581Hl39-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 90c4d88be15e11c1e922ef93e611b5e28103e37b  Merge branch 'pci/misc'

elapsed time: 1335m

configs tested: 17
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha              allnoconfig    gcc-16.1.0
alpha             allyesconfig    gcc-16.1.0
alpha                defconfig    gcc-16.1.0
arc               allmodconfig    gcc-16.1.0
arc               allyesconfig    gcc-16.1.0
csky              allmodconfig    gcc-16.1.0
i386              allmodconfig    gcc-14
loongarch            defconfig    clang-24
nios2             allmodconfig    gcc-11.5.0
nios2              allnoconfig    gcc-11.5.0
parisc            allmodconfig    gcc-16.1.0
parisc            allyesconfig    gcc-16.1.0
parisc               defconfig    gcc-16.1.0
sh                   defconfig    gcc-16.1.0
sh         edosk7760_defconfig    gcc-16.1.0
x86_64                   kexec    clang-22
x86_64            rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C143C044;
	Tue, 20 Jan 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916297; cv=none; b=ZYebSy9nkjZA3yw/RmMxEU2Ut2lHDImizc4IN2t4j106pw8LTFysJpt8JAo8B4ui1FBSQr71dhzcfjWV1HkQvauFiPR0WpEwzEBfEdz+UMguOgy2HQDtQSdlIXBhkXS5DMjn69sfBcQmjNYQ9vRMahecjhw8VsP6/zVTUscCLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916297; c=relaxed/simple;
	bh=pSSrWCIklsSRcJaHDIaB8EgbSGX9daEF0899fXydSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngz5v7O6N79vdFYigjQFFAb8va7lejrrj4pUAcXMw7QolTW+/F5t0QeVlxnmfRtyRoYDE0VE/lKfyNsJHHr6uSPPyF4tvyz58uonzKCw8Hx48FFzpVUy02U3f6TnKaT5JbM1BuQF1SRxOQXoE1yc+XXpJNokOr6XXYAlcuqdCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABDN1XJj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABDN1XJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768916296; x=1800452296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pSSrWCIklsSRcJaHDIaB8EgbSGX9daEF0899fXydSvM=;
  b=ABDN1XJjlQEpKgnPg0rA1uzPvy53EGqUwWsxk6ojTyW/6/RlD+pl+Kul
   R2MipMtNNldi5jkIXhQ/Wxk3vrgHn2wI9RImy8TikiI42G/2VdhdwCBCM
   xNExqj86gh5zzTOU9VbpTXxgS9qEwMk1IBo1woTYBbcbIP5+Ibhp7FKHy
   dU2T3EKmYS/ph1CF7MdeD9ZOx8m/ywya4ninM4Q+upVpeVnCHPJ3zoz2w
   nzgQ3KnfgutZEBlX/2RnkV/aCRCGDuGNy6XBX+7lJf81K+PKOsB+G+PC1
   s+fBqMXN4NYlcMZubKXq1ZGpbrtRX/C+QMpwEPSJs1xunBYfSpQZT4sDk
   w==;
X-CSE-ConnectionGUID: L2OLoiTSR8yIAY3uJQHqLw==
X-CSE-MsgGUID: d7DAMNcLQnyJHj6gF3TX9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69136154"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69136154"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:38:15 -0800
X-CSE-ConnectionGUID: 73lzpn1ESiSqsFV6nhzIQA==
X-CSE-MsgGUID: D/b+QLerQ+mFDkHAwRjTBg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Jan 2026 05:38:08 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viBvq-00000000P1t-2mNw;
	Tue, 20 Jan 2026 13:38:06 +0000
Date: Tue, 20 Jan 2026 21:37:11 +0800
From: kernel test robot <lkp@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dakr@kernel.org,
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
	helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com,
	jhubbard@nvidia.com, zhiwang@kernel.org,
	daniel.almeida@collabora.com, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from MMIO
 implementation
Message-ID: <202601202126.NVP5cs8k-lkp@intel.com>
References: <20260119202250.870588-3-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119202250.870588-3-zhiw@nvidia.com>

Hi Zhi,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next]
[cannot apply to driver-core/driver-core-linus pci/next pci/for-linus drm-rust/drm-rust-next linus/master v6.19-rc6 next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhi-Wang/rust-devres-style-for-imports/20260120-042526
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20260119202250.870588-3-zhiw%40nvidia.com
patch subject: [PATCH v10 2/5] rust: io: separate generic I/O helpers from MMIO implementation
config: x86_64-buildonly-randconfig-004-20260120 (https://download.01.org/0day-ci/archive/20260120/202601202126.NVP5cs8k-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601202126.NVP5cs8k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601202126.NVP5cs8k-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0599]: no method named `try_read32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:241:26
   |
   241 |         let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
   |                          ^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_read32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_read` with a similar name
   |
   241 -         let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
   241 +         let ctrl = iomap.try_read(th1520_pwm_ctrl(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_read32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:242:35
   |
   242 |         let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
   |                                   ^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_read32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_read` with a similar name
   |
   242 -         let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
   242 +         let period_cycles = iomap.try_read(th1520_pwm_per(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:294:15
   |
   294 |         iomap.try_write32(
   |         ------^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   294 -         iomap.try_write32(
   294 +         iomap.try_write(
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:302:19
   |
   302 |             iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_START, th1520_pwm_ctrl(hwpwm))?;
   |                   ^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   302 -             iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_START, th1520_pwm_ctrl(hwpwm))?;
   302 +             iomap.try_write(wfhw.ctrl_val | TH1520_PWM_START, th1520_pwm_ctrl(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_read32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:243:33
   |
   243 |         let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
   |                                 ^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_read32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_read` with a similar name
   |
   243 -         let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
   243 +         let duty_cycles = iomap.try_read(th1520_pwm_fp(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_read32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:275:33
   |
   275 |         let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
   |                                 ^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_read32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_read` with a similar name
   |
   275 -         let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
   275 +         let duty_cycles = iomap.try_read(th1520_pwm_fp(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:281:23
   |
   281 |                 iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
   |                       ^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   281 -                 iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
   281 +                 iomap.try_write(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:282:23
   |
   282 |                 iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
   |                       ^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   282 -                 iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
   282 +                 iomap.try_write(0, th1520_pwm_fp(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:283:23
   |
   283 |                 iomap.try_write32(
   |                 ------^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   283 -                 iomap.try_write32(
   283 +                 iomap.try_write(
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:291:15
   |
   291 |         iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
   |               ^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   291 -         iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
   291 +         iomap.try_write(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
   |
--
>> error[E0599]: no method named `try_write32` found for reference `&Mmio<176>` in the current scope
   --> drivers/pwm/pwm_th1520.rs:292:15
   |
   292 |         iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
   |               ^^^^^^^^^^^
   |
   = help: items from traits can only be used if the trait is in scope
   help: trait `Io` which provides `try_write32` is implemented but not in scope; perhaps you want to import it
   |
   23  + use kernel::io::Io;
   |
   help: there is a method `try_write` with a similar name
   |
   292 -         iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
   292 +         iomap.try_write(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
   |
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

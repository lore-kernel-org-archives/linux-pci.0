Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F11BD9D0;
	Sat, 31 Jan 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769851099; cv=none; b=LWaz5Xs8+FCQDzMxWNDUyMNqOlgIbleauRBms649ILEikVihk+H+3Z6Zn67RK0jBAUZMCAcHwtlzBTKI8BcMBh8biaSar9qI2TEDBqY9gHd6cLPxWnlV3eVQZ1dWDLnhDMa3bX+HFzLRQNlmevQ7irgnOBNKOYmjUbTYXx+KmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769851099; c=relaxed/simple;
	bh=Kb7VjzqM6dLDgKkYTNxquF86NIbpjxv0poCPEvi+eag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kENRglZ563CV7i2RWpw2tkEJMIEHQ8WmM6DwrpP6h6YkdEEQfyMYc+7FCtPG4i3Lif5d1wYwV7OWq/+YdnVHr+y0IstOxdCIpFMSqhVVzLVz6cJOKELOvU08dt+I4g51i1e2MKQAANQj/0XYY9V6xGBuJzT9BGGV71yWwy7n1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fErq2rTz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fErq2rTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769851098; x=1801387098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kb7VjzqM6dLDgKkYTNxquF86NIbpjxv0poCPEvi+eag=;
  b=fErq2rTz1zsKQZisDwZ0EgqiIapuiskJxgoDSK0l0wVE49GSup73ROWE
   FMd0NJwDM9t2BLr4eWlbg0+4TplsboPeuiHuaNYT4n9NovKCmLHS5otbg
   F6YudYmt9jLYOZyFxozLQhwQiUr3J2OmP4hE1a0zMGDzIbSPp47QrJuJU
   LmM/U3aBHTV1Ydaa2LHDMDfHXiOJ8lNcBtQ1Rd16DnexvnorF0YbqNj6X
   TiXmBH4gX5QXTJSBygyY+Q3TIrd6mQqVEEtAKRl23wWmVdt9S5rHFn+72
   b/4+MV2K5SkISoLBS14t+UDeUjs+jQtgTPnE1JGQsVzev73ws7b4tYXEP
   g==;
X-CSE-ConnectionGUID: WbtZKIH/ROOwsGgKb8q9hA==
X-CSE-MsgGUID: LxMR0pRIThmSs+ppGc5s1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71128321"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71128321"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 01:18:17 -0800
X-CSE-ConnectionGUID: UNC0jd1aRy6u3m9kyjmkvg==
X-CSE-MsgGUID: xU22GiErSSqETlTsD7eK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209451089"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 31 Jan 2026 01:18:14 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vm77M-000000002ft-0ir8;
	Sat, 31 Jan 2026 09:18:12 +0000
Date: Sat, 31 Jan 2026 10:17:30 +0100
From: kernel test robot <lkp@intel.com>
To: Zijing Zhang <zijing.zhang@ry.rs>, dakr@kernel.org,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
	kwilczynski@kernel.org, ojeda@kernel.org, gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: Re: [PATCH 2/2] samples: rust: pci: exercise capability lookup
Message-ID: <202601311056.PVHRBER5-lkp@intel.com>
References: <20260131040200.1242566-3-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131040200.1242566-3-zijing.zhang@ry.rs>

Hi Zijing,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260130]
[cannot apply to pci/next pci/for-linus v6.19-rc7 v6.19-rc6 v6.19-rc5 linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zijing-Zhang/rust-pci-add-capability-lookup-helpers/20260131-120935
base:   next-20260130
patch link:    https://lore.kernel.org/r/20260131040200.1242566-3-zijing.zhang%40ry.rs
patch subject: [PATCH 2/2] samples: rust: pci: exercise capability lookup
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260131/202601311056.PVHRBER5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260131/202601311056.PVHRBER5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601311056.PVHRBER5-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS= -fno-crash-diagnostics -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in samples/rust/rust_driver_pci.rs:138:
                ("SR-IOV", bindings::PCI_EXT_CAP_ID_SRIOV as u16),
            ] {
                if let Some(pos) = pdev.find_ext_capability(id) {
   -                dev_info!(pdev.as_ref(), "pci-testdev {name} ext cap @ 0x{:04x}\n", pos);
   +                dev_info!(
   +                    pdev.as_ref(),
   +                    "pci-testdev {name} ext cap @ 0x{:04x}\n",
   +                    pos
   +                );
                } else {
                    dev_info!(pdev.as_ref(), "pci-testdev has no {name} ext capability\n");
                }
   Diff in samples/rust/rust_driver_pci.rs:177:
                    );
                }
            } else {
   -            dev_info!(pdev.as_ref(), "pci-testdev selfcheck: no ext config space\n");
   +            dev_info!(
   +                pdev.as_ref(),
   +                "pci-testdev selfcheck: no ext config space\n"
   +            );
            }
        }
    }
   make[2]: *** [Makefile:1902: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

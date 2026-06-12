Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF0383304;
	Fri, 12 Jun 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265434; cv=none; b=XajpB+AOdBglEn1pVH9I0NhVjdIKjXBFvpCFTj2VT+UJR2tg08Kp50kI6NiNx2QXP3qNVz05zM/zFavlYCDGRP785PA5cRYkiF/apx3paDrUfbpvkErqWVODVOwam+lf96zxdWAWb3hJx93PwtMgBuvUKgeBX1aIzFw5pAlN7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265434; c=relaxed/simple;
	bh=3kgCEF0NcMdlJHyx8X2s5fXN3nPblSXVQBwdTy8XqMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsA0fXRZiapuKf5+iMVflSGH4FGyZNL2/DTkrqtUB7DAwn5Q5Qto9c7B57AyUI3FenxoTfIZZOHyyHk8Ehs1C9WXW8Hzha51yUtVxSZ3vHGu7hw9h/u7j16Am24bOBxINYvGoUlGu16LaHZjDfntSMhvWjwoXbHWehDYDs8di/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2Wx/vHN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2Wx/vHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781265429; x=1812801429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kgCEF0NcMdlJHyx8X2s5fXN3nPblSXVQBwdTy8XqMs=;
  b=d2Wx/vHN3NaCFSUt4m3dBE5bCXL1K3WNhY15HY2l071L8Pwlw18/YJ6W
   gi3dA1QgYp+PKl/ESFON2PRtdgSm083bbo6XANz3cXCX/qpUoUwKkClL+
   s7RrVhZaY6xg7CCgJBbOTkwDGnxpoJsq0njD2pjrX3NSOxr4KQWTN18bL
   tEY4ODEit9qHxv64P1f4VjKEg8vxMapd6JEsUpA76QpjQyg9tomKtPKTF
   Re/GpqTjUsX9qsvpnehuIJ0ZO7rRnkV8MexOg7RcuqHJ4xMgZGuMgkms0
   gR4yrAIZXt3asoYzKQKvyk//hjJS75R1ldn0s1Q+N6u4hJ4jhoU6g05p6
   Q==;
X-CSE-ConnectionGUID: Li1XXtwdQYuDbSw7pToo8g==
X-CSE-MsgGUID: wEwJZfhGS/KYid+jAiL5Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92414734"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="92414734"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:57:09 -0700
X-CSE-ConnectionGUID: C1nrmWAGT6OdmpBdfSthLw==
X-CSE-MsgGUID: IQ5Vxx7MQj6dK3sP/aU6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="251091665"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 12 Jun 2026 04:57:06 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wY0VT-000000004G1-3lN3;
	Fri, 12 Jun 2026 11:57:03 +0000
Date: Fri, 12 Jun 2026 13:56:28 +0200
From: kernel test robot <lkp@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	bhelgaas@google.com, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix TOCTOU race in reset
 path
Message-ID: <202606121343.Ix11WMZO-lkp@intel.com>
References: <20260612012832.2395034-2-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612012832.2395034-2-chandrashekar.devegowda@intel.com>

Hi Chandrashekar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20260611]
[cannot apply to bluetooth/master linus/master v7.1-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chandrashekar-Devegowda/Bluetooth-btintel_pcie-Fix-TOCTOU-race-in-reset-path/20260612-093045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260612012832.2395034-2-chandrashekar.devegowda%40intel.com
patch subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix TOCTOU race in reset path
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260612/202606121343.Ix11WMZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121343.Ix11WMZO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
   Documentation/ABI/stable/sysfs-class-bluetooth:1: ERROR: Unexpected indentation. [docutils]
>> Documentation/ABI/stable/sysfs-class-bluetooth:1: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/core-api/kref:328: ./include/linux/kref.h:72: WARNING: Invalid C declaration: Expected end of definition. [error at 96]
   int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
   ------------------------------------------------------------------------------------------------^
   Documentation/core-api/kref:328: ./include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
   int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)


vim +1 Documentation/ABI/stable/sysfs-class-bluetooth

514a8e6d6152a41 Hsin-chen Chuang 2025-01-20 @1  What: 		/sys/class/bluetooth/hci<index>/reset

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

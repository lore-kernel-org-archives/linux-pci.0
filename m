Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FED2D060D;
	Mon, 30 Mar 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904509; cv=none; b=Ob9eHvqNVeMscpCZuSvkZJLamcFsp9ryREwNoQRhipD930zGqT6GcVJd/zfhwT6JdXJ4R7WIH8yHr1ZL9tgWVBAYwQzGHwxwGXXCXlzAJnOdq7mWj35d6toHv67l8r8FkS+3c4Ss1jvbdSuYWMyPiuEoejVbIbxvgUgF4P7nFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904509; c=relaxed/simple;
	bh=7Bf6s5P7obYbKfi0McPxjoy/5AMRI2Ir4XDW4hxa6Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq4WbVqO7Dzi7O1WYZShQchOWLeyKvAEW8HG+t/XcP8CgjbrZpMJbew4ptfQYft61z9vMGUwXWDs32bqvbP2L7r2LN23hEvbux+fX7YepVBPlcpUbBs4bJQxQegx7TYxnY0wQ/gzAAJTJUv4EwcSWKK+bTEyF6jiYI/lkt6cjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnYpUs5i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnYpUs5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774904508; x=1806440508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Bf6s5P7obYbKfi0McPxjoy/5AMRI2Ir4XDW4hxa6Vs=;
  b=bnYpUs5ite5y6LOmC47rEspSzsfjd8RgK+f4JYwcOEJTJdRlPDH2UQyX
   JqXRyswpt7DyYRn4cqMBlx6hxa+vTutPOFfsQY9+LZ05K1oc4F18mhbwW
   8DlrepqpLgG6eSAW776zDfnmW+y9g+h35helS2U1kSUOaS44AgGwGXs5y
   AsPgc+2fGC7AD1mya7KkexlNzcddIy+8ViA6Jt2RUOpvqoWs8w6Q/evzP
   ZnLrpOkGVPO1/5trfbwPUxxACP4DhVhPnxbYc6mJG6D3/HzC0KGEPTUqt
   8mdQnGRK5pyJ3WW6TmmovRaezd0JO4F4R23qjLVmL11HRD/EjwxbmBfPN
   g==;
X-CSE-ConnectionGUID: 5Yh9+Hu4QImMINSw716bVw==
X-CSE-MsgGUID: 08ofLtjxROCg/nX9ritBSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79808838"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="79808838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:01:47 -0700
X-CSE-ConnectionGUID: 7nPBUnMATt+Vbc3qwsQHbg==
X-CSE-MsgGUID: PhNu3LhYSn+JH6lFCOg0zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="226038623"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 30 Mar 2026 14:01:45 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Jjy-000000001i1-0j2s;
	Mon, 30 Mar 2026 21:01:42 +0000
Date: Tue, 31 Mar 2026 05:01:23 +0800
From: kernel test robot <lkp@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie:Support Product level reset.
Message-ID: <202603310419.PsZ2njdQ-lkp@intel.com>
References: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>

Hi Chandrashekar,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20260327]
[cannot apply to bluetooth/master linus/master v7.0-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chandrashekar-Devegowda/Bluetooth-btintel_pcie-Support-Product-level-reset/20260330-190125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260330063842.1121545-1-chandrashekar.devegowda%40intel.com
patch subject: [PATCH v1] Bluetooth: btintel_pcie:Support Product level reset.
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20260331/202603310419.PsZ2njdQ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310419.PsZ2njdQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310419.PsZ2njdQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btintel_pcie.c:13:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/bluetooth/btintel_pcie.c:2307:7: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2307 |         if (!acpi_has_method(handle, "_PRR")) {
         |              ^
   drivers/bluetooth/btintel_pcie.c:2307:7: note: did you mean 'acpi_has_watchdog'?
   include/linux/acpi.h:1494:20: note: 'acpi_has_watchdog' declared here
    1494 | static inline bool acpi_has_watchdog(void) { return false; }
         |                    ^
   1 warning and 1 error generated.


vim +/acpi_has_method +2307 drivers/bluetooth/btintel_pcie.c

  2280	
  2281	static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
  2282	{
  2283		union acpi_object *obj, argv4;
  2284		acpi_handle handle;
  2285		int ret;
  2286		struct pldr_mode {
  2287			u16	cmd_type;
  2288			u16	cmd_payload;
  2289		} __packed;
  2290	
  2291		/* set 1 for _PRR mode
  2292		 * Product Reset (PLDR Abort flow)
  2293		 */
  2294		static const struct pldr_mode mode = {
  2295			.cmd_type = 1,
  2296			.cmd_payload = BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET |
  2297				       BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR,
  2298		};
  2299		struct hci_dev *hdev = data->hdev;
  2300	
  2301		handle = ACPI_HANDLE(GET_HCIDEV_DEV(data->hdev));
  2302		if (!handle) {
  2303			bt_dev_dbg(data->hdev, "No support for bluetooth device in ACPI firmware");
  2304			return -EACCES;
  2305		}
  2306	
> 2307		if (!acpi_has_method(handle, "_PRR")) {
  2308			bt_dev_dbg(data->hdev, "No support for _PRR ACPI method, falling back to FLR");
  2309			btintel_pcie_reset(data->hdev);
  2310			return -ENODEV;
  2311		}
  2312	
  2313		argv4.buffer.type = ACPI_TYPE_BUFFER;
  2314		argv4.buffer.length = sizeof(mode);
  2315		argv4.buffer.pointer = (void *)&mode;
  2316	
  2317		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
  2318					BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
  2319		if (!obj) {
  2320			bt_dev_err(data->hdev, "Failed to call dsm to set reset method");
  2321			return -EIO;
  2322		}
  2323		ACPI_FREE(obj);
  2324	
  2325		pci_dev_lock(data->pdev);
  2326		pci_save_state(data->pdev);
  2327		ret = btintel_acpi_reset_method(hdev);
  2328		if (ret)
  2329			bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d),PLDR incomplete",
  2330				   ret);
  2331		pci_restore_state(data->pdev);
  2332		pci_dev_unlock(data->pdev);
  2333		return ret;
  2334	}
  2335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

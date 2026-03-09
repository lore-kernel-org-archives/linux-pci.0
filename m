Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D52737EE;
	Mon,  9 Mar 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067604; cv=none; b=PMVLpIv8Mhgxr7HNVI2RjL33gQCdPJzpN6YzGYzsEetl+ckX1nJ0l8178GB6Try4GmEh5SiRI7bYXaIeFZACgzPn7zthS9khzfnnc3U1nAOoN/iiNmo1U3PBANOBbq1Yqqqxs8NX/I9IDRRVfYTqCUvYnnxlXIV+4N22Gcy/H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067604; c=relaxed/simple;
	bh=pcjyvkWqVZuL0hNKvXxSSPOe/Gza0z73iIY1s/J2RB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivh6CSR+eWudrHmxjsx5ahQpgkZYEqRdiUnm8aAxXAyjzTwRJmkgT9Jq+CpE37L9XZOz5L271eNvVK5bj5kd87RfCRVADSDb0ElqFzxxaiaqaAPVqwL1dztPHGJHstFgvyDhBolInVGlCpokSgmocOac9ua80VG8vjzF5ELt8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AuyTb/zV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AuyTb/zV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ap/5rAAlPzEySe5EbsdRcwWW15+LeFvh7y2Jk3wcWMs=;
	b=AuyTb/zV9D2YgeUgaBWTDKywgxokYtXmcEcy1zkWDEcswfCF07vcM3Ru9D40Qm
	3mHrswqM/BpOn/txl+QHJPRPKQGoJikWw372bvzLnMuyjMihtBjiyMg6NiIe2CFM
	i7PqnquVccnQOAxj03e0WbqGox660444CqOBCU8eFDe7Q=
Received: from [IPV6:240e:b8f:927e:1000:792:97b4:4a20:b2d3] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X50S3a5pFQwYAA--.8424S2;
	Mon, 09 Mar 2026 22:45:39 +0800 (CST)
Message-ID: <42c07f4a-d32b-4219-a0a7-ccec5f125b32@163.com>
Date: Mon, 9 Mar 2026 22:45:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260308142629.75392-3-18255117159@163.com>
 <202603090252.S3qQ67Kh-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202603090252.S3qQ67Kh-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X50S3a5pFQwYAA--.8424S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4UJr4Dur1xZrW5urykZrb_yoWrJr1xpa
	yUGw1qkF98J3yfWw1UtFW8ua4Yq3Z8ZayUGr9Igr1xuF1ayr1UuF10gaySyr9rKr4v9ryx
	KFy2kF9rCa4qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR3ku3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBSCJmmu3RQFgQAA3+



On 2026/3/9 02:10, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on c23719abc3308df7ed3ad35650ad211fb2d2003d]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-of-Remove-max-link-speed-generation-validation/20260308-223128
> base:   c23719abc3308df7ed3ad35650ad211fb2d2003d
> patch link:    https://lore.kernel.org/r/20260308142629.75392-3-18255117159%40163.com
> patch subject: [PATCH v7 2/2] PCI: dwc: Validate max-link-speed property
> config: csky-randconfig-r071-20260308 (https://download.01.org/0day-ci/archive/20260309/202603090252.S3qQ67Kh-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 10.5.0
> smatch: v0.5.0-9004-gb810ac53
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260309/202603090252.S3qQ67Kh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603090252.S3qQ67Kh-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from include/linux/kernel.h:16,
>                      from include/linux/clk.h:13,
>                      from drivers/pci/controller/dwc/pcie-designware.c:13:
>     drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_get_link_speed':
>>> include/linux/array_size.h:11:32: error: invalid application of 'sizeof' to incomplete type 'const unsigned char[]'
>        11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>           |                                ^
>     drivers/pci/controller/dwc/pcie-designware.c:128:19: note: in expansion of macro 'ARRAY_SIZE'
>       128 |      max_speed >= ARRAY_SIZE(pcie_link_speed) ||
>           |                   ^~~~~~~~~~
> 
Hi Bjorn and Mani,

I am currently working on a patch series aimed at removing the range 
check in the of_pci_get_max_link_speed() function and adding validation 
functionality in the DWC driver.

In patch 2 of v7, I used ARRAY_SIZE(pcie_link_speed) in the DWC driver 
to validate the "max-link-speed" attribute. However, the kernel test 
robot reported a build error [2] because pcie_link_speed is an 
incomplete type (only an external declaration) in the pcie-designware.c 
file, so ARRAY_SIZE cannot be used.

To solve this problem, I suggest adding a macro named "#define 
PCIE_LINK_SPEED_COUNT 16" in the <linux/pci.h> file to represent the 
fixed size of the pcie_link_speed array (with 16 entries according to 
the 4-bit field of the PCIe standard). Then use this macro in the DWC 
driver instead of using ARRAY_SIZE.

The reason for adding the macro instead of using the fixed value "16" is 
to make the code more self-explanatory and this array size can be used 
for many years in 16 cases.

Do you agree with this approach? Please let me know. Perhaps there are 
any other better methods?

Best regards,
Hans

> 
> vim +11 include/linux/array_size.h
> 
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03   6
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03   7  /**
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03   8   * ARRAY_SIZE - get the number of elements in array @arr
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03   9   * @arr: array to be sized
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03  10   */
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03 @11  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> 3cd39bc3b11b8d Alejandro Colomar 2023-10-03  12
> 


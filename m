Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3847CA6D;
	Sat, 12 Sep 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218907; cv=none; b=hsGd0ZnwqR+TfAtZwINePfJGH42fOPpFbNZRRaYwUP5317iU7hAEinGsNsGEsTgWYu05a9awWTG6Ndt5iY6lorOxHNziyuaXip/+LaF9UVZjxFZrDVBkdi5zD1AY3JMWQvI4l6GAOzcHtH86yOhDtpdeGdCmroJS2WeVsC/0Fp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218907; c=relaxed/simple;
	bh=aEqQPAM8IpJbzV5TaPpdI3LfTzG8+rxefu/liAzV82U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpaKr+FwTF9ktyKXc5ZQ7kz6JoTCkOCmqMSa2ZJrrHvWNMtZ3U7K7jKUx0iA9LlcXG87rL9PycTn5CLvkhdVlGky9dGA8TNfJ9ZeNTKJastXR6q2h9xGqjUEO/KTErgoYYtDc8QoeNrc6hOjUXRLeVNi0bSsmzD6HyVA+GkNICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+Qc4Gz1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+Qc4Gz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789218905; x=1820754905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aEqQPAM8IpJbzV5TaPpdI3LfTzG8+rxefu/liAzV82U=;
  b=j+Qc4Gz1dOM6Rp4SVqLi0x8sGZf9iMFZn4N7uYYz9nUZMKROQ6NefWY5
   aClBudoNr+ayyPgU+RzMJLzMmn5bt1YPoeCPGBXAEMCdFT6vWuVioyQTm
   1E8mtTuyNySUK59t0JRI4V9SsYi1GbyFWTL0JhtOgioUhyjcmj/awK3SD
   mhkJKyVqggSKq1EqjbI4PPfQ/LN5WxBMOQNnnfWHiFg59Fww6ZctTai8Y
   kFZPdkVHAPc5Cf9mG1WkH7+CKoUf8PDrFAnnkktMY1FGCVvLEOglO2Kli
   3xJMsFeFdOuD26z5wMyrQAquO59zL4L5+6XMDeoumEjKShznnBJJpVQ4L
   A==;
X-CSE-ConnectionGUID: 2amq7eqXR7CZVLbGzrPYsQ==
X-CSE-MsgGUID: Y2TUhAf5TaeuFVOYUYyQPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89669187"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="89669187"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:15:04 -0700
X-CSE-ConnectionGUID: yHcfrC34RlGyL6jJfZeyIA==
X-CSE-MsgGUID: wnRtCPr7Q8yzVRpKQ3wmdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="268901516"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:15:01 -0700
Date: Sat, 12 Sep 2026 16:14:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pavol Sakac <sakacpav@amazon.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	nh-open-source@amazon.com
Subject: Re: [RFC PATCH 5/8] drivers: base: test: Add KUnit suite for staged
 sysfs registration
Message-ID: <aqVQU6hbDPE5zOm-@ashevche-desk.local>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
 <20260911174414.97060-5-sakacpav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911174414.97060-5-sakacpav@amazon.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 07:43:37PM +0200, Pavol Sakac wrote:
> Add a staged_device KUnit suite under its own
> CONFIG_STAGED_DEVICE_KUNIT_TEST symbol exercising the staged mechanism.
> kobject_add() on a kobject with ->sd_staged builds the directory staged
> but does not publish it, since only device_add() does, so the tests
> drive the window directly: stage, then populate and observe, then
> sysfs_publish_dir(). The cases cover publication of plain, named-group
> and merged-group content, the failure modes of publication itself, abort
> without publication, foreign-thread access, concurrent windows including
> two that share one hashed staged mutex, glue-directory sharing, and
> bus-klist membership by the time device_add() returns. The suite also
> covers the KERNFS_STAGED_TOP/KERNFS_HAS_MMAP aliasing on a staged
> mmap-capable bin file.
> 
> The publication-misuse cases intentionally trigger the publication
> guards' WARN backtraces, and the duplicate-name cases trigger
> sysfs_warn_dup() splats: those backtraces are expected output of a
> passing run, not failures. The suite is therefore unsuitable for
> runners that set panic_on_warn, which turns the first intentional splat
> into a panic, and does not follow KUNIT_ALL_TESTS: it runs only when its
> symbol is enabled explicitly.

...

>  drivers/base/test/.kunitconfig         |    1 +

Same question, why is this file got modified?

...

> +++ b/drivers/base/test/.kunitconfig
> @@ -1,3 +1,4 @@
>  CONFIG_KUNIT=y
>  CONFIG_DM_KUNIT_TEST=y
>  CONFIG_GLUE_DIR_KUNIT_TEST=y
> +CONFIG_STAGED_DEVICE_KUNIT_TEST=y

It seems this series is based on some other series?

-- 
With Best Regards,
Andy Shevchenko



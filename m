Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488132E72F
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237009; cv=none; b=EeCrQWBDzWDOzHipUw7y0+FbODvpyLzoCNS7P6eqsvYBKNubUn2mqVgk2EoG1VP+eUfQ4SZ6cg9vl6UMRSNwYe+BTqNZI9ldw88EPjXV+c5jmun0+otj9BWYP3+6XsKcq7FzGUJ6hOfMoUKJkX7zgLbfPEoLnwSauKTZ4hRsa5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237009; c=relaxed/simple;
	bh=2dz68d3IIffgLX4URWZkOL5j0TmHliJyOzsjNddX9qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvv3RN+Chs9EMJRZ1LFjxa0lt0WtlyWQUMtGHuPjVwND301eoZJbOzW9JnMVrVNH6iwLj7jigirOHNLbWJFCJ8htHxzRkv+6q8r6557LviXjNcyySczNO9Q82SLUXj8Pz3VexpGcwtnysPUxAeoZ8KUPRqlEvAsrom1kzgPtGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1p0XKei; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1p0XKei"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38df94d4dd8so2781479a91.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784237007; x=1784841807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wrUaBLbbTwHv098p1q3JOceP8CDyR8hElSHBW7qR1/4=;
        b=D1p0XKeiNw0wz2nurr5IeJpU2USPWoaODN4YOsNGzYWLKjapmhuwB17eQbcSpQcQ1+
         61KVnc74cF6dcsRq9JHmR0ScLneakxq8getGNh0nlFOnfZAMjdxfk+S02eNOLCrlv/DK
         Hj33AU1B7AzXvZkMkibyWCmPSN6+mrqUsVNl55vxhVc545QC9pntLPXhXTTZgTUFSCVJ
         XbE3C4sYFC5Nr7GA6mSeU3eGLcMablWhdkYwFLs7CvUw9SshbU+HMRSSJqjCmsMYBSmb
         NsJgFyu1DHO6EtcjRaYZY7k0LOcqF7/P5MYaaGlLwx+xuE7yxRE8sb7/pU0kCCoA+Osa
         ADQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784237007; x=1784841807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wrUaBLbbTwHv098p1q3JOceP8CDyR8hElSHBW7qR1/4=;
        b=eFMPMYwlc6/8T3HzFRNo7TKUVhdIh6zpjdYqQ1Gj8PQF05SAqnFHupyjg9+l2R+/O6
         cRgBWp3vZH0BqwOMPJK95b7iLHScaepXkH/jzyYxVG020vHkvr4sFzmJYHxoxdfCb3/y
         bxjH4Zmmn1Ybkshi3XlT6Hr7JaenqYJk0qRzH2p7Eav0Fj69GcDp1i7pcfO48cuZVc6q
         pNCKa6qzCtcOix3WCXlEXNC/4rUfuFUEGYxYDL8Lu4vetZFRWS5Y297nqPNwESHjOCNH
         Rl56fy8HCd6zwcaW2MLnGYXm1lqaONUXsCkE0OFlq77ZBNu4fqfLWK1QtxAPx7VqJ0I3
         zNJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1hntEm2Q/j3cDAvAcygaotxNALaaBL/dDmSttIOxgYC+9tlygKonCfgHeuipZVaKP7UOcG01ow5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyazGw61J7UgzYh7BN7Gh6cHSabCT7lV5OOlAW4izYdlk3E6ap
	3hs6sQ+GUKe0V7tEZ7iqGkT8IFHjEKHzIVfUJmy8MtUXGr7N9/du/Jr8Tw9eJosfTw==
X-Gm-Gg: AfdE7cn7D4bTK2JY6v+wDYEXHhG4DjkdRqMSGIcXyBXic737E5XIryiGosKuXGNb3IL
	4l0k2cSOMi45TLW7bEtP4RypNQa71Hz4QYSnVqEs6tOAKCyDkVbZlCoyodTUKZRNfkF5ghlhK3m
	H6htnsD5adOL7J9vn0Yc0W4I7OylI3v0bZ4RaoAKJU+tVL7rfwUpveSBUscV51bdLOHisZCDtrm
	AlbUubpJBnAyFEEQDcAJq9L7ybeLynefM0P47MR4Dg2CVUnq+FrdlGjIj/jn46OgZzwxHifN44J
	RmLFR4pkzXQLCaFhVR8XBo0fS4F6jVl0QNKZZ6Mb2Tf33zTQEOmK6i1AdjKldzWbgWjCfmcnrwh
	YYYWkpnMGjyEkNhwaTOS1ZHF9cC5Zl7WK6cjHCQVSc3gduuQBfXFdGbyL/LwTs0TslCeTGoL+OL
	FnerV3k4WQSXFoJXVIO1v0E6KhybFf54kEkykVYvoL
X-Received: by 2002:a17:90b:3d90:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-38e467597f3mr1142655a91.16.1784237006752;
        Thu, 16 Jul 2026 14:23:26 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39fe37d1sm1841599a91.12.2026.07.16.14.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:23:25 -0700 (PDT)
Date: Thu, 16 Jul 2026 21:23:22 +0000
From: David Matlack <dmatlack@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <allLypOmtbnPrgbw@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>

On 2026-07-16 03:51 PM, Matt Evans wrote:
> Hi David,
> 
> On 15/07/2026 19:12, David Matlack wrote:
> > On Wed, Jul 15, 2026 at 10:47 AM Matt Evans <matt@ozlabs.org> wrote:
> > 
> >> This is based on v7.2-rc3.
> >>
> >> These commits are on GitHub for easier browsing, along with
> >> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
> >>
> >> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-mmap-v5
> > 
> > It'd be great to have this test upstream. I'm happy to review it when
> > you're ready. Looks like it just needs to be redone to use the VFIO
> > selftests library and kselftests harness. AI could probably do the
> > conversion pretty quick :)
> 
> For sure, I'd intended to catch up with you on best approach here. :)
> 
> Aside from the organic structure of the test (the open-coded VFIO
> device/group setup/init needs to go), the main issue is that it relies
> on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> (containing freely read-writable memory).  A subset of tests run with
> the in-tree EDU device, but coverage is too low.
> 
> The desirable properties are:
> 
>  - Having a BAR that is pure memory (all locations present, writable
> without disruptive side-effects) so that mapping aliases can be
> constructed and detected.  This is good to test things like non-zero
> vm_pgoffs and VA space presentation of physically-discontiguous DMABUFs.
> 
>  - BAR >> hugepage size so we can eyeball huge mappings work (or better,
>  mechanically test for them).  At least 32MB would tick this box for 4K,
> 16K page systems.
> 
>  - Something QEMU supports*, so one can run the test in a VM/TCG system.
> 
> There were some real device models in QEMU that could be used this way,
> but needed a fair bit of setup;  I didn't want to rathole
> vfio_dmabuf_mmap_test on including a ton of device-specific code for
> some video card or similar.
> 
> I'll dig more for a simple target that provides these properties --
> obviously it would be better to point this test at an off-the-shelf
> device (including silicon!).  And, proposing EDU extensions to the QEMU
> folks may be useful (there're uses for a better EDU in other contexts too).
> 
> Since this test uses MMIO for a specific [class of] function, my first
> thought is it should be another VFIO driver-type test sibling of
> vfio_pci_driver_test.  For example, we could extend the driver-type
> tests' backend struct vfio_pci_driver_ops for functions capable of
> providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> could also support vfio_pci_driver_test.
> 
> The spirit of the device backends hiding setup of a complex device is
> handy, and it's plausible that several backends could provide this "big
> memory BAR" service.  What do you think, any concerns with extending
> vfio_pci_driver_ops like that?

I wouldn't recommend leveraging the driver framework unless absolutely
necessary. It makes the test harder to run.

The biggest issue I see with the proposed properties is being able to
treat the BAR as memory. That obviously will depend on the device and
may require device-specific setup. If we decide that treating the BAR as
memory is truly required then using the driver framework is the way to
go. But I'm hoping we can avoid that requirement.

Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
to determine if the mmap() set things up correctly, without actually
accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
PAGEMAP_SCAN to detect huge pages.

With that requirement gone, then all you really need is a device with a
large enough BAR. And even that it not a hard requirement. I'm sure
there are plenty of test cases that could work with smaller BARs. The
few tests that want to exercise huge mappings can inspect the device BAR
sizes first, and if they're all too small, SKIP() the test.

If you structure the test this way, then it's easy for the test to be
used. It can be run against any device for the basic functional
coverage, and can be run against a device with a larger BAR for full
coverage of huge mappings.

Does QEMU emulate any devices that have 32MB or larger BARs?

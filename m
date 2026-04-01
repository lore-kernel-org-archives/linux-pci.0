Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829B305E1F;
	Wed,  1 Apr 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054214; cv=none; b=QMAt5QNzR8YQk8briqpe5awsjvQbGO0Mts8m6XOwIgpO0jwnV4ZbCCigmf2ML42YdFEf8ZG3TFeHx/+7ia88k3xJeDMtXZvbUAMM+brBHQa+WUwCpW1jrsUOwK8wSwvlxVWrukgb7x6A5q480PLwRs1+TROw5XTZx84+pxFlj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054214; c=relaxed/simple;
	bh=RihWe9fQIxmIgwDhwcNSbhkpSL03nKNn1qbJPB0J2+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hieG0fJpUJB9tY/pUXKmGz52bbO6BuM2igjOy2DRJEmg+60SRPPm/kb51DMv8H7Sgy4sC0bb/FUldXLVv4gkdJZykctg+4Y6Q+ecBWE9h9ipk8OO7qySs2BY17h27JRcZ1PJM7nrbx3ZOfbpFzpyX8nrgHGWhHeQaeVS8B6xKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh1uVFU6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh1uVFU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA7AC4CEF7;
	Wed,  1 Apr 2026 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775054214;
	bh=RihWe9fQIxmIgwDhwcNSbhkpSL03nKNn1qbJPB0J2+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mh1uVFU6JNai1F9LdjWZbPPl7KJBJc8d/UReYXUGnDCRuxJaxSzbVyb7uI1yVk0eY
	 z4tCaC1+/jcFn4w7FOqjQ5BcWgrcLvdBZQzSVhYpDx26G+zrVLqFu14gCt8nS+Vi5h
	 Ifn3lWC0ydfzvZHrDwRLhJVy/vnguhYMQZ6l43sez2ujouO57nd14+jJqIsNMuLjTZ
	 qsftSArXs+pzZFPBoUFoOUWsuqKUAjQ/4tInVAjNM80oBXZLDQZQZZu14Wg+LXTNBF
	 ChHo0rv201AbzjEGvwdUL3WGHrR1zPBnYNTp0o7SujROuhxgfybL+8NoXMIyzSXYsG
	 8x5XQRwJKsnHA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex Mastro
 <amastro@fb.com>,  Alistair Popple <apopple@nvidia.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Ankit Agrawal <ankita@nvidia.com>,  Bjorn
 Helgaas <bhelgaas@google.com>,  Chris Li <chrisl@kernel.org>,  David
 Rientjes <rientjes@google.com>,  Jacob Pan
 <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Jason
 Gunthorpe <jgg@ziepe.ca>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Kevin Tian <kevin.tian@intel.com>,
  kexec@lists.infradead.org,  kvm@vger.kernel.org,  Leon Romanovsky
 <leon@kernel.org>,  Leon Romanovsky <leonro@nvidia.com>,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  linux-pci@vger.kernel.org,  Lukas Wunner <lukas@wunner.de>,  =?utf-8?Q?M?=
 =?utf-8?Q?icha=C5=82?=
 Winiarski <michal.winiarski@intel.com>,  Mike Rapoport <rppt@kernel.org>,
  Parav Pandit <parav@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pranjal Shrivastava <praan@google.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Raghavendra Rao Ananta
 <rananta@google.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,  Saeed
 Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Shuah Khan <skhan@linuxfoundation.org>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  Tomita Moeko <tomitamoeko@gmail.com>,
  Vipin Sharma <vipinsh@google.com>,  Vivek Kasireddy
 <vivek.kasireddy@intel.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 06/22] vfio/pci: Retrieve preserved device files
 after Live Update
In-Reply-To: <aaDZ-ffs4kiUo3GY@google.com> (David Matlack's message of "Thu,
	26 Feb 2026 23:40:41 +0000")
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-7-dmatlack@google.com>
	<20260226155222.5452a741@shazbot.org> <aaDZ-ffs4kiUo3GY@google.com>
Date: Wed, 01 Apr 2026 14:36:44 +0000
Message-ID: <2vxzjyuqhhmr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 26 2026, David Matlack wrote:

> On 2026-02-26 03:52 PM, Alex Williamson wrote:
>> On Thu, 29 Jan 2026 21:24:53 +0000 David Matlack <dmatlack@google.com> wrote:
>
>> > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> > index 8ceca24ac136..935f84a35875 100644
>> > --- a/drivers/vfio/device_cdev.c
>> > +++ b/drivers/vfio/device_cdev.c
>> > @@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>> >  	vfio_device_put_registration(device);
>> >  	return ret;
>> >  }
>> > +EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
>> 
>> I really dislike that we're exporting the underscore variant, which
>> implies it's an internal function that the caller should understand the
>> constraints, without outlining any constraints.
>> 
>> I'm not sure what a good alternative is.  We can drop fops since this
>> isn't called from file_operations.  Maybe vfio_device_cdev_open_file().
>
> Ack. Due to the bug you pointed out below, I think the changes in this
> file will look fairly different in the next version. But no matter what
> I'll avoid exporting a underscore variant without outlining the
> constraints.

I haven't yet had a chance to read v3 so maybe you already solved this
problem. But I dealt with some similar problems for the memfd patches
[0] and the hugetlb patches [1]. What I did was to just use/add a
internal header (mm/internal.h or mm/hugetlb_internal.h). This lets you
share functions within your subsystem but avoid exporting everywhere
else.

I see that there already is drivers/vfio/vfio.h so perhaps you can use
that to avoid exporting these functions outside the subsystem?

[0] https://git.kernel.org/torvalds/c/ed6f45f81bf9
[1] https://lore.kernel.org/linux-mm/20251206230222.853493-6-pratyush@kernel.org/

[...]

-- 
Regards,
Pratyush Yadav

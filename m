Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA326ED3E;
	Sun,  1 Feb 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964137; cv=none; b=CiLu8wYg9opmh+cJnCuKOuoCXi0H1xT3rWAXzPgDAyfbGMhPe2Pt9Ll4yNA6eIS/pgQOWRzryLFgrJ0vlnDKJw/wiDsxlKgownKN2YdxzHW3SbUSiWVBamRMR83IWzhiqHV8HWqF53sgK+DPACr+MRfQu4tSVfkXTS2ePqc46aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964137; c=relaxed/simple;
	bh=Xcg5dMcD3gfNoe5awtJkp8+RbxVdfVBZaTZPNqrYjsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixbLVBKzJoQfVMG5or+2jwp/dRLyDlnpMVy/AgpXEIf9Jf/Lxmvikwzb/qkjnDH352JHbSZG9Fh0V5/o8Obj4Tz8ys2TgopTHXxTXf0wJO7Uv2vcK79lfOIdYnyjP+BrmkpPZ2nvRMdY7V8rg+WnhF8eia4mnH05+VCJDDjSe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxcwkt/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxcwkt/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB24C4CEF7;
	Sun,  1 Feb 2026 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769964137;
	bh=Xcg5dMcD3gfNoe5awtJkp8+RbxVdfVBZaTZPNqrYjsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mxcwkt/NJDeCumyF+iPJGRDfOF3UVmIcxHuGv004PbaOKxTzEL5UkW7GumCL3+MQr
	 ybGXH39WMcFOrskVirc1pFP7TCthYqwzVis2cs01ea0LyoKNo4OTAU08wUrYuq3NCG
	 XMZHtCMgMTBBmoeChxlsqlrK5/JZtWJvUYGgktcRq7YAHq8kEKdGoG9tijXzjZAeLw
	 ac1k8JaBEGEijEeSvUNipJT4oXqPMfVZsbwrdOvtxuSOrELHK6ol9r+wMeqe9zDetR
	 BuG+UMRquoetvBTT2jt63tRn6an4Fuxk4spFesgZfw0j/NHkVjA27tCkdn6c9EKxMc
	 T/90nh4ZXqImA==
From: Thomas Gleixner <tglx@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, spasswolf@web.de, Mario Limonciello
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Joanthan
 Cameron <Jonathan.Cameron@huawei.com>, Joel Granados
 <joel.granados@kernel.org>, John Ogness <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, Li Huafei <lihuafei1@huawei.com>, "Luck, Tony"
 <tony.luck@intel.com>, Luo Gengkun <luogengkun@huaweicloud.com>, Max
 Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo
 <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, Thorsten Blum
 <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>,
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, W_Armin@gmx.de
Subject: Re: crash during resume of PCIe bridge from v5.17 to next-20260130
 (v5.16 works)
In-Reply-To: <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
 <87v7h5ia3d.ffs@tglx>
 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
 <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
 <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
Date: Sun, 01 Feb 2026 17:42:13 +0100
Message-ID: <87a4xs2z6i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 01 2026 at 01:36, Bert Karwatzki wrote:
> I found the error, the commit 
> ("drm/amd: Check if ASPM is enabled from PCIe subsystem")
> has been applied twice first as cba07cce39ac and a second time
> as 7294863a6f01 after it had been superseeded by commit
> 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device") 
> This effectively disables ASPM globally after the built-in GPU (which does not
> support ASPM) is probed. This is the reason for the crashes and loss of devices
> errors which on average occur after ~1000 resumes of the discrete GPU.

Wow. Nice detective work...

Return-Path: <SRS0=UFJ4=EG=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=UFJ4=EG=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180110233515.GI241460@bhelgaas-glaptop.roam.corp.google.com>
References: <1513170333-19102-1-git-send-email-mheyne@amazon.de> <20180110233515.GI241460@bhelgaas-glaptop.roam.corp.google.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Jan 2018 16:05:44 -0800
Message-ID: <CAKgT0Uf28XKcAiU=URR8H3xJnOdmfeKRDdVNCzrTbH_ao-mvVA@mail.gmail.com>
Subject: Re: [PATCH] pci-stub: enable SR-IOV configuration through sysfs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Maximilian Heyne <mheyne@amazon.de>, linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Sorry for top-posting but I am just going to throw a recap of the
discussions as I recall them on top of this since the code itself
isn't so much the subject of review.

I would imagine this has the same issues that we were talking about
for the VFIO or UIO solutions for this. Basically the discussion all
came down to the fact that doing this potentially exposes the kernel
to a possible security issue since the PF might be managed by an
untrusted source. I believe the last discussion we had about the VFIO
based solution ended in us needing to have a way to make it so that
the auto-probe value could be changed and be restored after the
user-space managed PF driver was unloaded and/or SR-IOV was disabled.
Basically we can't risk tainting the kernel by auto-loading the VF
drivers on the kernel when the PF is managed by an unknown entity or
user space.

- Alexander

On Wed, Jan 10, 2018 at 3:35 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Alex, Alex, Jeff, Liang-Min, kvm, LKML]
>
> Anybody else have any thoughts on this?
>
> On Wed, Dec 13, 2017 at 02:05:33PM +0100, Maximilian Heyne wrote:
>> Currently, SR-IOV VFs can only be configured through sysfs, if a driver
>> is loaded for the device. Sometimes we don't care about the PF, but only
>> want to assign VFs to guests, which is now possible with this patch.
>>
>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

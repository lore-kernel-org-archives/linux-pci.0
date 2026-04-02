Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4838D6A3
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163766; cv=none; b=X6my79TBE37epJk1dFIMVeVu8zaAJpO3D7DjD+SS//WUpbICPAbF+C16c//A996EWC88neqngDehlZUqgj9NAWiM3zgF7qYK1pWEy0eNzPBhTkcDExlgt+I87MUeu56CDZVt0zOB2qTQ0Gdmij4c6DpobVTvXNh3Id6XdKxkJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163766; c=relaxed/simple;
	bh=rlicR5iwvlRo+aY+MKh3IG088B/PxfEdkqVqQXbC0nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L43omY3GqR6IykR3/RnYzTS+qGBUBX7Gr6Qw4af6nkcPHWMGSBI/jDe38II7N1L1SFD+b2gTig0JKfLcLQgEmuBq+GCk5rqD3XT5oJATMSYtt+6KAX0/rdIk+MfE0ftu1XwDd5lqM6DUSiAKhksZzgvy/E3jc1dd3a+Nam7Y/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASCIbD7S; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASCIbD7S"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82418b0178cso683793b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775163761; x=1775768561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVAbUsQSEIuYDKSpvRncD6Pl/NcrClHYMjDh9yyOEzY=;
        b=ASCIbD7SuQ7aZ51Zzwfd7vKtNotg0ICMq1guZFEDwpnPS/qxuzE/HeX9OEhFHfFEQh
         Si4Ve+RAcM438uYHh66UWUGF+6Dh2JIfwTMhubf9zM/ZuaUiavAMLMnKNdfugoEatlAR
         9HcAShIdtedU8MNnTmHiuPlA2cnfLbLXnkXUuF2jdK2KnGGcrL7Gayog7c6oLIAe5e9b
         +xaMahQ3nUyKi0vJDMGYu9J9hBKR9zJMhrz1oyAKs2RIUjbTC7bwyy7Ezi25XeLMaV9A
         NmQIG/xk30kaaa0ck2WQl/D1fUBR1WBtGqOWvltacN+uWc5K4cXUasS/SShVr+RspzRZ
         vFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163761; x=1775768561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVAbUsQSEIuYDKSpvRncD6Pl/NcrClHYMjDh9yyOEzY=;
        b=Bz+kaS+sy9vSs8pYI81QDmAGu9s18UBdfb3Z0YlI2do1nEL5bq+VnE1JUL2m2rMrUy
         hL3Os4Y4F7Vd/KXRYYgYlWF8WDHjpjU9sMYue/tR3vepEcXWI6/rRa+UeTLcQnNG2ewU
         Tl7669nNQ9oVvK9+Y6obMY+6QRUfRCuTkjObSXZLvtfI/ow/d5wmvaOU2FwBVRwRwfEh
         UCPnB1sMGLdndtJBFVZ1I1N2IwMTMhvZ0kdx95dX4n0kFyuEEBW/n3gBcdK4hrf8wf/T
         clK9lmebDb2/EJDqq36xgvaKEUKx74olzFBav6M6xDeSjEORsSrSHM5uUp3uJOj+wPbp
         IrDw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Mw5nryK7DN2ab8yZP3CS6PO2CYdJCOKEp2UsSRhPCvxeCxmMcpH20O4Lo19BJpWuvdgsc+GvZgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNGuhEQhPnOR7gZopqD84N8Y80iECPDhr8lFowKuyzsEztggj
	47Xh+wkrBsQRL77tfUkuFdIBY67OV9skdEiGPJvVOJIwLfSDnEHr5DssNIWoHH3sI9TresUIvwW
	fs/nQWQ==
X-Gm-Gg: ATEYQzxBedgI9cupiGPsOYKBk/P28dGY55hy+NCMaUWG0Z/Q3tu2GSn00XdrCH/gEHT
	GcFz+qexpRg8NiM8foweW5o+zyXBSO/Rdr6+IteHnlHVz3i8n9agxBusI/2bKrYFRJLu0N2G4Ux
	hFoZTAYzxuh6P2Q9WcID2To+4dkwuOuWJ1e7uaotZoWH8FPbnnxV9e11rEVOmFGmRQ+LxUkEgyc
	2LGkUCg8AyzswPSDoXFOa3nxiXemg8YJ5OG+5bBxOYgAxscOumQqUcI0O5K51u/PbIQYB5L9p1d
	LziO7YQ+Xuk7gcqPJ/GL4SYsJ9HFzxYPKrzn6vmDzptwHj6rROjh/SI7XCJ2fAgGM9t49cDJC9W
	yvav8b7yte+VKfN847lKuMNLMOahkTiiv4SAtVuVwOlUZVnukHTD0w4XRqli7QrlRc35v5+U6ZC
	9blLtnk2VmaRyw2SXPd+5OFs+2zA+NUmXPtQdHaO1MtEZUW2qT9r6FqwJdFqs9bw==
X-Received: by 2002:a05:6a00:301f:b0:82c:9fe1:aa4e with SMTP id d2e1a72fcca58-82d0da8f68amr610555b3a.21.1775163760821;
        Thu, 02 Apr 2026 14:02:40 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1644sm3861192b3a.55.2026.04.02.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:02:39 -0700 (PDT)
Date: Thu, 2 Apr 2026 21:02:35 +0000
From: David Matlack <dmatlack@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU
 drivers
Message-ID: <ac7ZazqDHIVfOPtC@google.com>
References: <20260327211649.3816010-1-dmatlack@google.com>
 <d309de55-a1ec-4c99-b464-9ae9c0d9e027@linux.intel.com>
 <CALzav=d8GxA6uT6FDeThZkT4n7auvp=iuYWAhytbiCuq5dBWkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=d8GxA6uT6FDeThZkT4n7auvp=iuYWAhytbiCuq5dBWkQ@mail.gmail.com>

On 2026-03-31 08:32 AM, David Matlack wrote:
> On Mon, Mar 30, 2026 at 8:32 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 3/28/26 05:16, David Matlack wrote:
> > > Ensure that PCI devices with ATS disabled via quirk have it disabled
> > > before IOMMU drivers are notified about the device rather than after.
> > > Fix this by converting the existing quirks from final to early fixups
> > > and changing the quirk logic to set a new no_ats bit in struct pci_dev
> > > that prevents pci_dev.ats_cap from ever gettting set.
> > >
> > > This change ensures that pci_ats_supported() takes quirks into account
> > > during iommu_ops.probe_device(), when IOMMU drivers are first notified
> > > about devices. It also ensures that pci_ats_supported() returns the same
> > > value when the device is released in iommu_ops.release_device().
> > >
> > > Notably, the Intel IOMMU driver uses pci_ats_supported() in
> > > probe/release to determine whether to add/remove a device from a data
> > > structure, which easily leads to a use-after-free without this fix.
> >
> > Can you please shed more light on the above issue? In my investigation,
> > iommu_ops.probe_device() is always called after the no_ats quirk,
> > regardless of whether this patch is applied.
> >
> > The diff of the changes I made for testing is as follows:
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 442271a1b92a..c024964ac53b 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3271,6 +3271,8 @@ static struct iommu_device
> > *intel_iommu_probe_device(struct device *dev)
> >                                  info->pfsid = pci_dev_id(pci_physfn(pdev));
> >                          info->ats_qdep = pci_ats_queue_depth(pdev);
> >                  }
> > +               pci_info(pdev, "ATS %s\n", info->ats_supported ?
> > +                        "supported" : "not supported");
> >                  if (sm_supported(iommu)) {
> >                          if (pasid_supported(iommu)) {
> >                                  int features = pci_pasid_features(pdev);
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 48946cca4be7..c63616d108b7 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5714,6 +5714,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,
> > 0x1457, quirk_intel_e2000_no_ats);
> >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459,
> > quirk_intel_e2000_no_ats);
> >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a,
> > quirk_intel_e2000_no_ats);
> >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c,
> > quirk_intel_e2000_no_ats);
> > +
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0b25, quirk_no_ats);
> >   #endif /* CONFIG_PCI_ATS */
> >
> >   /* Freescale PCIe doesn't support MSI in RC mode */
> >
> >
> > The related kernel messages are shown below:
> >
> > # dmesg | grep "0000:00:01.0"
> > [   15.834944] pci 0000:00:01.0: [8086:0b25] type 00 class 0x088000 PCIe
> > Root Complex Integrated Endpoint
> > [   15.836382] pci 0000:00:01.0: BAR 0 [mem
> > 0x1e0fff980000-0x1e0fff99ffff 64bit pref]
> > [   15.836655] pci 0000:00:01.0: BAR 2 [mem
> > 0x1e0fff900000-0x1e0fff93ffff 64bit pref]
> > [   15.837904] pci 0000:00:01.0: calling
> > quirk_igfx_skip_te_disable+0x0/0xe0 @ 1
> > [   15.838614] pci 0000:00:01.0: quirk_igfx_skip_te_disable+0x0/0xe0
> > took 0 usecs
> > [   21.205177] pci 0000:00:01.0: calling  quirk_no_ats+0x0/0x40 @ 1
> > [   21.206767] pci 0000:00:01.0: disabling ATS
> > [   21.207916] pci 0000:00:01.0: quirk_no_ats+0x0/0x40 took 1122 usecs
> > [   21.305357] pci 0000:00:01.0: DMAR: ATS not supported
> > [   21.306925] pci 0000:00:01.0: Adding to iommu group 4
> > [   42.564912] idxd 0000:00:01.0: Intel(R) Accelerator Device (v200)
> > [   42.568653] probe of 0000:00:01.0 returned 0 after 87413 usecs
> >
> >
> > Anything I missed?
> 
> The Closes link above has the details of my investigation:
> 
>   https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> 
> Can you check if you see the same ordering for VFs? That was the
> scenario where I saw the IOMMU drivers notified before final fixups
> were applied.

During boot I observe the same order as you. PCI final fixups get
applied twice actually, and both times is before iommu probe_device().

First time:

[    1.687987][    T1] pci 0000:00:04.0: pci_fixup_device
[    1.690987][    T1] WARNING: drivers/pci/quirks.c:227 at pci_fixup_device+0xd5/0x230, CPU#5: swapper/0/1
[    1.708986][    T1] RIP: 0010:pci_fixup_device+0xf9/0x230
[    1.755989][    T1]  pci_bus_add_device+0x31/0x90
[    1.758986][    T1]  pci_bus_add_devices+0x39/0x70
[    1.760986][    T1]  acpi_pci_root_add+0x815/0xa60
[    1.767986][    T1]  acpi_bus_attach+0x260/0x2f0
[    1.773988][    T1]  device_for_each_child+0x6a/0xa0
[    1.775986][    T1]  acpi_dev_for_each_child+0x39/0x60
[    1.780986][    T1]  acpi_bus_attach+0xe8/0x2f0
[    1.785987][    T1]  device_for_each_child+0x6a/0xa0
[    1.787989][    T1]  acpi_dev_for_each_child+0x39/0x60
[    1.792985][    T1]  acpi_bus_attach+0xe8/0x2f0
[    1.795986][    T1]  acpi_bus_scan+0x6a/0x200
[    1.799986][    T1]  acpi_scan_init+0xb7/0x1c0
[    1.803988][    T1]  acpi_init+0xad/0xd0
[    1.808986][    T1]  do_one_initcall+0xba/0x2a0
[    1.825986][    T1]  do_initcall_level+0x7c/0xf0
[    1.827988][    T1]  do_initcalls+0x43/0x70
[    1.829986][    T1]  kernel_init_freeable+0xd7/0x140
[    1.834985][    T1]  kernel_init+0x1a/0x130
[    1.836986][    T1]  ret_from_fork+0xf4/0x280
[    1.840985][    T1]  ret_from_fork_asm+0x1a/0x30

Second time:

[    4.156625][    T1] pci 0000:00:04.0: pci_fixup_device
[    4.159282][    T1] WARNING: drivers/pci/quirks.c:227 at pci_fixup_device+0xd5/0x230, CPU#1: swapper/0/1
[    4.178115][    T1] RIP: 0010:pci_fixup_device+0xf9/0x230
[    4.228013][    T1]  pci_apply_final_quirks+0x6a/0x170
[    4.233485][    T1]  do_one_initcall+0xba/0x2a0
[    4.251171][    T1]  do_initcall_level+0x7c/0xf0
[    4.253521][    T1]  do_initcalls+0x43/0x70
[    4.255653][    T1]  kernel_init_freeable+0xd7/0x140
[    4.260602][    T1]  kernel_init+0x1a/0x130
[    4.262745][    T1]  ret_from_fork+0xf4/0x280
[    4.267345][    T1]  ret_from_fork_asm+0x1a/0x30

Then iommu probe_device() happens:

[    5.744756][    T1] pci 0000:00:04.0: intel_iommu_probe_device
[    5.747688][    T1] WARNING: drivers/iommu/intel/iommu.c:3257 at intel_iommu_probe_device+0x3e9/0x840, CPU#1: swapper/0/1
[    5.767127][    T1] RIP: 0010:intel_iommu_probe_device+0x403/0x840
[    5.816998][    T1]  __iommu_probe_device+0xe7/0x4d0
[    5.819522][    T1]  probe_iommu_group+0x29/0x50
[    5.824593][    T1]  bus_for_each_dev+0x111/0x130
[    5.826965][    T1]  iommu_device_register+0xfb/0x250
[    5.829492][    T1]  intel_iommu_init+0x36f/0x450
[    5.834374][    T1]  pci_iommu_init+0x16/0x40
[    5.836614][    T1]  do_one_initcall+0xba/0x2a0
[    5.854121][    T1]  do_initcall_level+0x7c/0xf0
[    5.856450][    T1]  do_initcalls+0x43/0x70
[    5.858563][    T1]  kernel_init_freeable+0xd7/0x140
[    5.863427][    T1]  kernel_init+0x1a/0x130
[    5.865522][    T1]  ret_from_fork+0xf4/0x280
[    5.870169][    T1]  ret_from_fork_asm+0x1a/0x30

But when VFs are created the order is reversed:

[  545.718507][  T242] pci 0000:01:00.1: intel_iommu_probe_device
[  545.718627][  T242] WARNING: drivers/iommu/intel/iommu.c:3257 at intel_iommu_probe_device+0x3e9/0x840, CPU#0: bash/242
[  545.719468][  T242] RIP: 0010:intel_iommu_probe_device+0x403/0x840
[  545.721181][  T242]  __iommu_probe_device+0xe7/0x4d0
[  545.721278][  T242]  iommu_bus_notifier+0x37/0x100
[  545.721373][  T242]  blocking_notifier_call_chain+0x62/0x100
[  545.721485][  T242]  bus_notify+0x97/0xc0
[  545.721567][  T242]  device_add+0x222/0x400
[  545.721646][  T242]  pci_device_add+0x488/0x6e0
[  545.721746][  T242]  pci_iov_add_virtfn+0x2f2/0x3e0
[  545.721935][  T242]  sriov_add_vfs+0x2c/0x60
[  545.722064][  T242]  sriov_enable+0x306/0x4a0
[  545.722157][  T242]  virtio_pci_sriov_configure+0x6a/0x90
[  545.722257][  T242]  sriov_numvfs_store+0xd7/0x1c0
[  545.722349][  T242]  kernfs_fop_write_iter+0xfe/0x180
[  545.722453][  T242]  vfs_write+0x2e4/0x460
[  545.722533][  T242]  ksys_write+0x70/0x100
[  545.722613][  T242]  do_syscall_64+0xd1/0x8b0
[  545.722832][  T242]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  545.725241][  T242] pci 0000:01:00.1: pci_fixup_device
[  545.725339][  T242] WARNING: drivers/pci/quirks.c:227 at pci_fixup_device+0xd5/0x230, CPU#0: bash/242
[  545.727806][  T242]  pci_bus_add_device+0x31/0x90
[  545.727902][  T242]  pci_iov_add_virtfn+0x3c9/0x3e0
[  545.728118][  T242]  sriov_add_vfs+0x2c/0x60
[  545.728226][  T242]  sriov_enable+0x306/0x4a0
[  545.728320][  T242]  virtio_pci_sriov_configure+0x6a/0x90
[  545.728416][  T242]  sriov_numvfs_store+0xd7/0x1c0
[  545.728512][  T242]  kernfs_fop_write_iter+0xfe/0x180
[  545.728609][  T242]  vfs_write+0x2e4/0x460
[  545.728690][  T242]  ksys_write+0x70/0x100
[  545.728771][  T242]  do_syscall_64+0xd1/0x8b0
[  545.728866][  T242]  ? clear_bhb_loop+0x30/0x80
[  545.728961][  T242]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

My naive reading of the PCI hotplug code makes me think it has the same
ordering as VF creation. More generally, any PCI device that is added
after the IOMMU bus notifiers are set up will probe the device before
final fixups are applied. I can clarify that in the commit message in
v3.

Here is the patch I used to collect the traces above:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ef7613b177b9..122cb8f610a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3254,6 +3254,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
        info->dev = dev;
        info->iommu = iommu;
        if (dev_is_pci(dev)) {
+               pci_WARN(to_pci_dev(dev), 1, "intel_iommu_probe_device\n");
                if (ecap_dev_iotlb_support(iommu->ecap) &&
                    pci_ats_supported(pdev) &&
                    dmar_ats_supported(pdev, iommu)) {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..af9cb39c9236 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -224,6 +224,7 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
                break;

        case pci_fixup_final:
+               pci_WARN(dev, 1, "pci_fixup_device\n");
                if (!pci_apply_fixup_final_quirks)
                        return;
                start = __start_pci_fixups_final;

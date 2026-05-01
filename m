Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172771E492D;
	Fri,  1 May 2026 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601286; cv=none; b=HbhQYeCaD9rInxwCKnRz9sMoTAKDQ/qK+WWOv734+INtTEeF7b8pNbNrO3rWoWFRQJeNM7GAs/AqCCk03eXFH7zNP9T9txiucWmhNnjRx+O1E6r+OWpx717UUHePvamjwSbMICfeotMsFoFcu1OFRgEy+zFx88N1rmgXpewwpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601286; c=relaxed/simple;
	bh=239xtwrYmK7zmIrn9uwdGKs1DagHxfJ1xzER9nlddWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6bLNSGCC00jAT/DjhBY4qH1jF/wb7lTUF+OPlTKoEQP7al2Cd2BJdEKv4X6o89xXvKc38J+VcOOpID4wWljkY8N9sUR5MpWmI4K9rhOUSwqnPjxGNEkp2oy7M+Pe6syUYVNQ5Fc5f2mMkJGsXi57NK0YqLUYWMhZ3kb/C42h/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l70oC63f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l70oC63f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA11C2BCF4;
	Fri,  1 May 2026 02:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777601285;
	bh=239xtwrYmK7zmIrn9uwdGKs1DagHxfJ1xzER9nlddWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l70oC63fKlvmHCsdmWSCfCGXBq4HyZeio8CNk6IAJBFhaTvvvBbWS9Rg6fwSNl2kp
	 6n3CifW0HpysXOwSWvVhA1j9v4TrlBb04qxWqn0JqYuFLeII4oghrPHOoFxlJ6PKX2
	 ukSpt1B2JUZSIAjqxtS2JrFpBGlnHTAEdXB+AM4BGkdtJ8sqlptpp6HS3hCfcFJPQ1
	 q8EojdFkdazjBh/dMMv0kKgIKMDgQttVzyB2urHSvW7GM0fLDfsWJ3BGeDlbS9p5vQ
	 CDIXQyi5hVkOtXl9y8IcBk1LG/xaqEeH2PtXqsQw14t+IPSGBRHqtClqMOwXB4Hsb2
	 yxwXhKbID/saw==
Date: Fri, 1 May 2026 11:08:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lukas@wunner.de, mani@kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Shuan He <heshuan@bytedance.com>
Subject: Re: [PATCH v2] PCI: Remove redudant call to pci_proc_attach_device()
Message-ID: <20260501012539.GB990551@rocinante>
References: <20260228072129.10445-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20260309225018.GA636900@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309225018.GA636900@bhelgaas>

Hello,

> > Hence, remove the call to pci_proc_attach_device() from pci_proc_init().
> 
> Seems plausible, but given that this code has been this way basically
> forever, I'd sure like to figure out what's different about Shuan and
> Lorenzo's system that makes this issue show up now.

Sadly, removing the for_each_pci_dev() loop breaks x86/ACPI systems
where it's the only mechanism creating per-device procfs entries.

On x86 with ACPI, PCI enumeration happens at subsys_initcall (level 4),
two levels before pci_proc_init() runs at device_initcall (level 6).

When the pci_bus_add_device() calls pci_proc_attach_device() during
enumeration, proc_initialized is still 0, so the call returns -EACCES
and no entry is created:

  subsys_initcall (level 4):                                                                                                                                                                                      
    acpi_init()                                                                                                                                                                                                 
      acpi_scan_init()                                                                                                                                                                                            
        acpi_bus_scan()                                                                                                                                                                                           
          acpi_pci_root_add()                                                                                                                                                                                     
            pci_acpi_scan_root()             <- devices are discovered                                                                                                                                              
            pci_bus_add_devices()
              pci_bus_add_device()
                pci_proc_attach_device()
                  if (!proc_initialized)     <- variable is not yet set
                    return -EACCES

  device_initcall (level 6):
    pci_proc_init()
      proc_initialized = 1
      for_each_pci_dev()                     <- iterates existing devices
        pci_proc_attach_device()             <- creates the procfs entries

Without that loop, the /proc/bus/pci/XX/YY.Z entries are never created
on these systems.  This can be verified under QEMU q35 with ACPI, where
removing the loop results in an empty /proc/bus/pci directory.

On platforms using Devicetree, the loop is usually not a problem, as host
bridges probe at the same device_initcall level, and with the current link
order, the pci_proc_init() runs first, so the loop finds zero new devices
and then pci_bus_add_device() creates the entries inline.  The race happens
when async probing causes both paths to overlap.

The fix needs to keep the loop but make it safe.  I have a patch that
wraps it with pci_lock_rescan_remove() and adds a simple dev->procent
idempotency check to pci_proc_attach_device(), see:

  https://lore.kernel.org/linux-pci/20260430003542.455198-1-kwilczynski@kernel.org

The lock serialises against concurrent pci_bus_add_device() calls,
and the dev->procent check makes the function idempotent so that
if both paths reach the same device, the second one returns early.
This also keeps code symmetric with pci_proc_detach_device(),
which already clears dev->procent.

Let me know what do you think, and if you have some other ideas.  Perhaps
there is a better way to do this.  Sadly, no static procfs attributes
exist for procfs, so this avenue is not available to us.

Thank you!

	Krzysztof

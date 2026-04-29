Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DE361DAB;
	Wed, 29 Apr 2026 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493081; cv=none; b=XMS2Dftx/nuMN+r9yTr70u320HLbs2lKvory2SqQBUJCmGjJBa+W13FgXoVto5S8/r8FIBRF5ch/Uq+fbSAyjRnpW4aM2dGaff9RKWbhXg4y2xJpl8381mR4/S9UFFoGZwUCRok9ZUXAKeL6GYpVz6c5hyQuDE5nI9i99b55x0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493081; c=relaxed/simple;
	bh=ttY+1mHK9AUaFpm72RQJRVBgW0SdDDoYGSZPfSaYn18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pJhSNbxNw2WAs8YxRtfHlWiEFBy+wQkUI3QzaKwswCbKxCpefsWAL4IjUO1B2a4Z1a5KHfSFe+FufFCYPkPO0yPPIiX3H/DdUiV4lLLJTdqyE30TJhKyA5VwKps5vfqDdlHqdqaWjPz3PStraB3plcE+y7OvXSAoCnuUl545wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9Meet6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9Meet6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B4EC19425;
	Wed, 29 Apr 2026 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777493081;
	bh=ttY+1mHK9AUaFpm72RQJRVBgW0SdDDoYGSZPfSaYn18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M9Meet6zdZ092aa4T3HcHb7qbc9y2d7f0V3nvhcYbz7VpQsFYwmC7UJVoEjPi1HrZ
	 1s0gRx/lJVkhwvW9Zq3xpSigh3w9c7FeON2NpdzSn03NdUREW9KXxrVXdBNexmtV9K
	 ls9FGE95CD7IQLdMYHj/etYTSCFanT6wYHdRCiugf1Th3rRfrso6NXvdS83wsHqfRy
	 sMaC5l9P6Y3qiQI7+NWZ/khmEmnUv+1UoWcrVSYh9GZ4qEIRzA9jDPE3qydC4eBwE6
	 oesaYOz5RjyWWdayV0t18WECKRCApBbo7ftCyA+53ImFXKYmwZ5DzCDmeUzBgH0RyW
	 NTURaN9BR5hpA==
Date: Wed, 29 Apr 2026 15:04:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	moubingquan <moubingquan@h-partners.com>, Ian <4dark@outlook.com>,
	Koba Ko <kobak@nvidia.com>,
	Koen Vandeputte <koen.vandeputte@citymesh.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Artem Savkov <artem.savkov@gmail.com>,
	Korneliusz Osmenda <korneliuszo@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260429200439.GA313340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>

[+cc moubingquan, Ian, Koba, Krzysztof H, Koen, Pali, Artem,
Korneliusz, Alexander
+bcc vsd
in case any of you can verify that this fixes the issue you reported]

On Wed, Apr 22, 2026 at 04:13:43PM +0000, Krzysztof Wilczyński wrote:
> Hello,
> 
> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.
> 
> Currently, the PCI resource files (resourceN, resourceN_wc) and the
> legacy bus files (legacy_io, legacy_mem) are created dynamically
> from two unsynchronised paths:
> 
> Path A: late_initcall
> 
>   pci_sysfs_init                        (late_initcall)
>     sysfs_initialized = 1
>     for_each_pci_dev
>       pci_create_sysfs_dev_files
>         sysfs_create_bin_file           (resourceN, resourceN_wc)
>     pci_find_next_bus
>       pci_create_legacy_files
>         sysfs_create_bin_file           (legacy_io, legacy_mem)
> 
> Path B: device registration / hotplug
> 
>   pci_bus_add_devices
>     pci_bus_add_device
>       pci_create_sysfs_dev_files
>         if (!sysfs_initialized) return  <- only guard
>         sysfs_create_bin_file           (resourceN, resourceN_wc)
> 
> On most ACPI systems this does not race because PCI enumeration
> completes at subsys_initcall time, before pci_sysfs_init() runs:
> 
>   subsys_initcall (level 4):
>     acpi_pci_root_add
>       pci_bus_add_device
>         pci_create_sysfs_dev_files
>           if (!sysfs_initialized)          <- not yet set
>             return -EACCES
> 
>   late_initcall (level 7):
>     pci_sysfs_init
>       sysfs_initialized = 1
>       for_each_pci_dev
>         pci_create_sysfs_dev_files         <- creates the files, no race
> 
> On Devicetree platforms the host controller is a platform driver that
> probes via the driver model, often on a workqueue, and overlaps with the
> late_initcall:
> 
>   CPU 0 (late_initcall)                CPU 1 (driver probe)
>   ---------------------------          ----------------------------
>   pci_sysfs_init()
>     sysfs_initialized = 1
>     for_each_pci_dev(pdev)             pci_bus_add_device(pdev)
>       pci_create_sysfs_dev_files()       pci_create_sysfs_dev_files()
>         sysfs_create_bin_file()            sysfs_create_bin_file()
>                                              -> "duplicate filename"
> 
> The same happens on ACPI when probing is asynchronous (hv_pci on
> Azure, RISC-V with ACPI).
> 
> The duplicate causes sysfs_create_bin_file() to fail with -EEXIST.
> pci_create_resource_files() then calls pci_remove_resource_files() in
> its error unwind, tearing down files the other thread created and
> still references through pdev->res_attr[].  This has caused kernel
> panics on i.MX6 and boot failures on other platforms.
> 
> Several different fixes have been proposed over the years: reordering
> the sysfs_initialized assignment, adding locks, checking
> pci_dev_is_added(), setting pdev->res_attr[] to NULL after kfree
> (which only prevents a double-free on the teardown path, not the
> error unwind removing the other thread's files).  None would address the
> root cause.
> 
> This has been reported a few times:
> 
>   - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com/
>   - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com/
>   - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/
>   - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
>   - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
>   - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
>   - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
>   - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-artem.savkov@gmail.com/
>   - https://bugzilla.kernel.org/show_bug.cgi?id=215515
>   - https://bugzilla.kernel.org/show_bug.cgi?id=216888

Seems like some or all of these should be mentioned in the relevant
patch as "Closes:" tags?

> With static attributes the driver model creates sysfs entries once per
> device at device_add() time, under the device lock, eliminating the
> late_initcall iteration and the race along with it.

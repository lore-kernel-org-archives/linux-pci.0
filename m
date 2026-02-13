Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE613280014;
	Fri, 13 Feb 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010769; cv=none; b=V5HnIAZNZScSmMiJOCCGSXWIuyVX4H8VMejNg304kHGKJDtdZPQbMyORPyiFX7qKD02C1Yy+99YuEmaMWbCWa6k+bsRhPFCE30d015MUzbNEZwbuZppcPCQvHB3Rqwnp1kHpgLTmc83aOQtla73tecDdwPRMLumg/0EEhUpNRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010769; c=relaxed/simple;
	bh=OWWrmiJn3brG/tKtBfwhmjftYweBWbiMSVyUQbGfjdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jRzd+dZePhIFyVpjHSqLhn4ecaBC1dngfgXZh/G9e1AddgM6kWvsQHKoNDDBgOLPGpk8gHZ2VfK/kZLKanqILWb5xOcKIG/M8PVZjMqX5+xUsXjIeBEYkzy78TQ3mE1dZjwJdqO0jgHMaosb4MRO4YHYtpmPzDYpPuj94ScbDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ2xEaJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ2xEaJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762CDC116C6;
	Fri, 13 Feb 2026 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771010768;
	bh=OWWrmiJn3brG/tKtBfwhmjftYweBWbiMSVyUQbGfjdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PZ2xEaJP/jcqly9XUexxpvFbT8BX3rYWtvL2oPo/vcLtmUc8xHJMzlpYGPrAi17c3
	 oQNlpauoUnoGQTSmTZ34X+D9X5Dd+ffuv/zeQ9RPbbKl3NBj8/+7pA4dYwfaZ6ysp2
	 PkhtKrC/PUFerblfZ120znh8z7S4VURzu/eAqNp06Fad/L9gMwcMm3Atcvou4mhYfC
	 WVe4okLY/t921QYjCZJ4nHLwvgMaW6GjHwsSqtVjYhZi/i37VdJNEKMNi/xiLpcIU0
	 OAqsOWAtkKiRcZfqB/GSaMrwlnnxBd9afEDLZvXjgE6bc0o0VlhoPlTtRgYFkdbh1t
	 Q5ASz3G2B2HDw==
Date: Fri, 13 Feb 2026 13:26:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	Jay Vosburgh <jay.vosburgh@canonical.com>, kengyu@lexical.tw,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
Message-ID: <20260213192607.GA3167656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKAwkKuD2XF1-32RrOsWRV_wXuiPP1BoFMcH8pA0HLEczKz3jw@mail.gmail.com>

[+cc Brian, author of 51c0996dadae ("PCI/PM: Prevent runtime suspend
until devices are fully initialized") (though it's not clear to me
whether this makes any difference)]

On Fri, Feb 13, 2026 at 06:54:13PM +1300, Matthew Ruffell wrote:
> Hi Mario,
> 
> I have been doing some experiments with c5.metal on AWS with an
> Ubuntu resolute userspace and a 7.0 merge window kernel.
> 
> Amazon AMI:
> ami-04080dce0ccaa893d
> 
> Linux HEAD 582a1ef360a05bff4350bbf6e383f61d26b804f0 (Linus's tree).
> 
> $ sudo lspci
> https://paste.ubuntu.com/p/mtgbn2HJtW/
> 
> $ sudo lspci -vvv -t
> https://paste.ubuntu.com/p/s6NhBz5FZy/
> 
> I noticed that nvme_pci_enable() calls pci_set_master() with the pci
> device, and I wondered, is this called with the NVMe device, so I
> went and had a look.
> 
> I added your patch:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 595ec12d85df..bd116dccd897 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1300,6 +1300,7 @@ int pci_power_up(struct pci_dev *dev)
>      bool need_restore;
>      pci_power_t state;
>      u16 pmcsr;
> +    u16 old_cmd;
> 
>      platform_pci_set_power_state(dev, PCI_D0);
> 
> @@ -1347,6 +1348,10 @@ int pci_power_up(struct pci_dev *dev)
>          udelay(PCI_PM_D2_DELAY);
> 
>  end:
> +        pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
> +        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
> +                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
> +
>      dev->current_state = PCI_D0;
>      if (need_restore)
>          return 1;
> 
> as well as some additional logging in nvme_pci_enable:
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 80df992d1ae8..2d1898016d40 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2992,6 +2992,7 @@ static bool nvme_pci_update_nr_queues(struct
> nvme_dev *dev)
> 
>  static int nvme_pci_enable(struct nvme_dev *dev)
>  {
> +    dev_info(dev->ctrl.device, "mruffell: nvme_pci_enable() start/n");
>      int result = -ENOMEM;
>      struct pci_dev *pdev = to_pci_dev(dev->dev);
>      unsigned int flags = PCI_IRQ_ALL_TYPES;
> @@ -2999,6 +3000,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>      if (pci_enable_device_mem(pdev))
>          return result;
> 
> +    pci_info(pdev, "mruffell: nvme_pci_enable() set master\n");
>      pci_set_master(pdev);
> 
>      if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> @@ -3064,11 +3066,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>      result = nvme_pci_configure_admin_queue(dev);
>      if (result)
>          goto free_irq;
> +    pci_info(pdev, "mruffell: nvme_pci_enable() end\n");
>      return result;
> 
>   free_irq:
>      pci_free_irq_vectors(pdev);
>   disable:
> +    pci_info(pdev, "mruffell: nvme_pci_enable() disable\n");
>      pci_disable_device(pdev);
>      return result;
>  }
> 
> So, booting the system on a clean reboot, we see nvme_pci_enable
> does infact get called with the nvme device, and all PCI devices in
> D0 with the bus master bit enabled.
> 
> https://paste.ubuntu.com/p/zp3khwfMg2/
> 
> Then I did a kexec.
> 
> https://paste.ubuntu.com/p/SWB5jz6x4g/
> 
> nvme_pci_enable() still gets called, but it doesn't seem to change
> anything.  The system still fails to issue I/O to the NVMe and all
> pci devices say the bus mastering bit is disabled in D0.
> 
> I then reverted
> 
> commit 51c0996dadaea20d73eb0495aeda9cb0422243e8
> Author: Brian Norris <briannorris@chromium.org>
> Date:   Thu Jan 22 09:48:15 2026 -0800
> Subject: PCI/PM: Prevent runtime suspend until devices are fully initialized
> 
> commit 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Wed Jun 11 18:31:16 2025 -0500
> Subject: PCI/PM: Set up runtime PM even for devices without PCI PM
> 
> commit 4d4c10f763d7808fbade28d83d237411603bca05
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Wed Apr 23 23:31:32 2025 -0500
> Subject: PCI: Explicitly put devices into D0 when initializing
> 
> and repeated the tests.
> 
> This time, on a clean reboot I get:
> 
> https://paste.ubuntu.com/p/qm6ZBWNqG5/
> 
> I get no messages about bus mastering at all. I did a kexec reboot
> and the system comes up correctly, again with no messages about bus
> mastering. So we must return early before the printout.
> 
> I then added some more logging, to see if we can see what state
> these devices are in:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bd116dccd897..deed439af6e4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1302,10 +1302,16 @@ int pci_power_up(struct pci_dev *dev)
>      u16 pmcsr;
>      u16 old_cmd;
> 
> +    state = platform_pci_get_power_state(dev);
> +    pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
> +        pci_info(dev, "Initial: Bus mastering bit is %sabled in %d\n",
> +                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis", state);

If you include "%s", paired with "__func__", in the printf string,
we'll get the locations directly.

>      platform_pci_set_power_state(dev, PCI_D0);
> 
>      if (!dev->pm_cap) {
>          state = platform_pci_get_power_state(dev);
> +        pci_info(dev, "mruffell: pci power state is %d\n", state);
>          if (state == PCI_UNKNOWN)
>              dev->current_state = PCI_D0;
>          else
> @@ -1349,7 +1355,7 @@ int pci_power_up(struct pci_dev *dev)
> 
>  end:
>          pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
> -        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
> +        pci_info(dev, "mruffell: final: Bus mastering bit is %sabled in D0\n",
>                  (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
> 
>      dev->current_state = PCI_D0;
> 
> The result for a clean reboot is:
> 
> https://paste.ubuntu.com/p/qh84c8T9ND/
> 
> We seem to skip pci_power_up() entirely for most devices, including
> the NVMe drive. Those that enter pci_power_up() are in state 5, or
> PCI_UNKNOWN.
> 
> I did a kexec, and we get:
> 
> https://paste.ubuntu.com/p/D2GhjKxDG3/
> 
> Pretty much identical results, and the system comes up correctly.
> Each time the bus mastering printout at the very end of
> pci_power_up() is never called.
> 
> The only conclusions I can seem to draw from this is when "PCI:
> Explicitly put devices into D0 when initializing" is present, all
> devices get their bus mastering bit, and are placed into D0, and on
> kexec, all devices lose their bus mastering bit and never get it
> back again.
> 
> If we revert "PCI: Explicitly put devices into D0 when
> initializing", devices that work bypass pci_power_up(), get their
> bus mastering bits set correctly, and kexec works.

Thanks for all your instrumentation and debugging!

I don't think it's safe for the PCI core to indiscriminately enable
bus mastering during boot.  That allows devices to DMA to/from system
memory even if there's no driver to operate the device.  Bus mastering
should only be enabled by a driver.

Per D2GhjKxDG3, nvme_pci_enable() is being called after the kexec, as
it should be.  We need to figure out why it isn't enabling bus
mastering.

It looks like something is wrong before we even get to
nvme_pci_enable() because it took 80+ seconds to get there after
kexec (D2GhjKxDG3), vs 2 seconds for the clean reboot (qh84c8T9ND).

Can you please put the entire dmesg log in a pastebin, possibly also
with a note about the circumstances and a pointer to another pastebin
with the "git diff" from upstream to the kernel?  It's hard for me to
pull all the pieces together from the excerpts and keep track of which
logs correspond to reboots vs kexecs, etc.

Bjorn

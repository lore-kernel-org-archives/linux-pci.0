Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAE3A383D;
	Wed, 11 Mar 2026 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271185; cv=none; b=Goccj+rd+di2KCcK0x0ipB0ll8pf8aGS9FfKG1YcUL1xohjM/haVitQ/nBXHVdJYBPyQBgxkXovwKZAlEc8cj23VEetgtTirkYsVf8ZgAd2Le1oZzBtNKZBaT29Hp62hnFqbAcPC9vn2o/J+ky2YSnOW3OEWfyYYjhucf86lRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271185; c=relaxed/simple;
	bh=5aSQN/NldnjFjPpTboJ5pMhiKK1OlI7zkpw+ZW6kjJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ozDMhZ347WmitHEmCEENEvHSAYJNm2oALR3HKriHKaI4F0juX6MKFsaCUuM9nxSQs7rug3WtYs1/Ric2A6j2PWaPuDbeBiF8NMgXEFLXRcWHg+tjKMoffaEFtxM4jGvx3Alsybxr5RPZ+l/z004iY6ddLfwcHeHwe8bLoHwyCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0z9sOQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0z9sOQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED4EC4CEF7;
	Wed, 11 Mar 2026 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773271184;
	bh=5aSQN/NldnjFjPpTboJ5pMhiKK1OlI7zkpw+ZW6kjJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o0z9sOQtzEdM5odwJqolqLMCemPxE6zb+1cxQV4jSdHh+9bI2SP5sP4I8L2AXz35m
	 Ob7eQoKg4BoI5RX+WGoWwPhjHAwyIFkkQiRyCormpJtJEIfgfWu0pyiNTeq5SAFzBs
	 ZmgFQv7fIUc0zy7li5I3UOPuuRqgQyfn/ZLyanJK6BteTvun4amJcW8iNtS1R30DK8
	 g1hlEtaCxIpYo5M6RRWVsZpFg0A3S6efWsuo919TGUAssxKKRrXmWiyllJhnfx/ZUx
	 DjgXBjDjt+v+h7ebyitPVh2UzlyaAhjqQn0mCMbA3TAbv+7XgA4HjtLA1h+nYZ6dnz
	 MIghT7BMnipig==
Date: Wed, 11 Mar 2026 18:19:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Jin <shawn.jin@asteralabs.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Message-ID: <20260311231943.GA1086074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>

[+cc Ilpo]

On Wed, Mar 11, 2026 at 10:00:39PM +0000, Shawn Jin wrote:
> Hello,
> 
> I'm reporting a potential critical bug in the Linux kernel's PCIe
> resource allocation code that creates invalid bridge window limit
> addresses during hotplug re-enumeration after Secondary Bus Reset
> (SBR) recovery.

Thanks for the report and the repro and debugging information!

> ## AFFECTED KERNEL VERSIONS
> - Confirmed: 5.15.0, 6.8.0 (Ubuntu 6.8.0-88-generic, 6.8.0-90-generic)
> - Likely affected: All recent kernels including 6.19

Do you know of any kernels that are *not* affected?  If you do, we
could bisect.

> ## HARDWARE CONFIGURATION
> Intel Ice Lake server with PCIe Gen5 switches and endpoints:
> 
> Topology 1:
>   Root Port 96:01.0 → 98:00.0 → 99:01.0 → 9b:00.0 (NVIDIA L20 GPU)
> 
> Kernel parameter: pci=realloc=on
> 
> ## PROBLEM DESCRIPTION
> 
> After performing Secondary Bus Reset on a PCIe switch port and
> clearing the reset bit, the kernel re-enumerates devices and assigns
> bridge window resources. However, the assigned memory window limit
> addresses are INVALID according to PCIe specification.
> 
> ### Evidence from dmesg (Topology 1):
> 
> **Before SBR (correct allocation):**
> ```
> [    6.636493] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
> [    6.636539] pci 0000:98:00.0:   bridge window [mem 0xe9600000-0xe96fffff]
> [    6.636645] pci 0000:98:00.0:   bridge window [mem 0x13b000000000-0x13b7ffffffff 64bit pref]
> 
> [    6.644429] pci 0000:99:01.0: PCI bridge to [bus 9b]
> [    6.644476] pci 0000:99:01.0:   bridge window [mem 0xe9600000-0xe96fffff]
> [    6.644656] pci 0000:99:01.0:   bridge window [mem 0x13b000000000-0x13b7ffffffff 64bit pref]
> 
> [    6.654203] pci 0000:9b:00.0: [1e3e:0002] type 00 class 0x120000 PCIe Endpoint
> [    6.654652] pci 0000:9b:00.0: BAR 0 [mem 0x13b000000000-0x13b7ffffffff 64bit pref]
> [    6.654666] pci 0000:9b:00.0: BAR 2 [mem 0xe9600000-0xe963ffff]
> ```
> 
> **After SBR clear (INVALID allocation):**
> ```
> [  656.644184] pci 0000:98:00.0: bridge window [mem 0x13b000000000-0x13b7ffffffff 64bit pref]: assigned
> [  656.644186] pci 0000:98:00.0: bridge window [mem 0xe9600000-0xe96fffff]: assigned
> [  656.644188] pci 0000:99:01.0: bridge window [mem 0x13b000000000-0x13b7fffffffe 64bit pref]: assigned
> [  656.644189] pci 0000:99:01.0: bridge window [mem 0xe9600000-0xe96ffffe]: assigned
> 
> [  656.644830] pci 0000:9b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space
> [  656.644831] pci 0000:9b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to assign
> // BAR2 can still be assigned because the size is only 256KB, while the min window in the bridge is 1MB
> [  656.644832] pci 0000:9b:00.0: BAR 2 [mem 0xe9600000-0xe963ffff]: assigned
> 
> ```
> 
> ### Invalid Addresses Created by Kernel:
> - `0x13b7ffffffff` (ends in 0xFFFE - **2 bytes short**)
> - `0xe96ffffe`  (ends in 0xFFFE - **2 bytes short**)
> 
> ## IMPACT
> 
> 1. **Device initialization failure**: Endpoints cannot allocate required BARs
>    ```
> [  656.644830] pci 0000:9b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space
> [  656.644831] pci 0000:9b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to assign
>    ```
> 
> 2. **Consistent across multiple hierarchies**: Affects different PCIe topologies independently
> 
> ## REPRODUCTION
> 
> The attached script test_rc_sbr.sh.txt issues a SBR to the root port.
> 
> ## SUSPECTED ROOT CAUSE
> 
> The bug appears to be in `drivers/pci/setup-bus.c`, likely in:
> - `pci_bus_distribute_available_resources()`
> - `adjust_bridge_window()`
> - `pci_assign_unassigned_bridge_resources()`
> 
> The resource end address calculation appears to perform multiple subtractions:
> 1. Initial calculation: `res->end = res->start + size - 1` (correct)
> 2. During redistribution: Another subtraction occurs, creating `res->end = ... - 2`
> 
> ## WORKAROUND ATTEMPTS
> 
> - `pci=realloc=on`: Does NOT fix the issue
> - Manual remove/rescan from root: Does NOT fix the issue
> - Initial boot allocation: Works correctly (bug only occurs during hotplug re-enumeration)
> 
> ## REQUEST
> 
> I want to track how the bridge windows are allocated. Is there a way
> to enable additional kernel messages to show the path? Please
> investigate if this is a real kernel bug.
> 
> Thank you,
> Shawn

> #!/bin/bash
> 
> # Function to display usage
> usage() {
>     echo "Usage: $0 -rp <ROOT_PORT_BDF> -usp <USP_BDF>"
>     echo "Example: $0 -rp c6:01.0 -usp c7:00.0"
>     exit 1
> }
> 
> # Initialize variables
> ROOT_PORT_BDF=""
> USP_BDF=""
> 
> # Parse command-line arguments
> while [[ $# -gt 0 ]]; do
>     case $1 in
>         -rp)
>             ROOT_PORT_BDF="$2"
>             shift 2
>             ;;
>         -usp)
>             USP_BDF="$2"
>             shift 2
>             ;;
>         -h|--help)
>             usage
>             ;;
>         *)
>             echo "Unknown option: $1"
>             usage
>             ;;
>     esac
> done
> 
> # Validate that both arguments are provided
> if [ -z "$ROOT_PORT_BDF" ] || [ -z "$USP_BDF" ]; then
>     echo "Error: Both -rp and -usp arguments are required"
>     usage
> fi
> 
> echo "Root Port BDF: $ROOT_PORT_BDF"
> echo "USP BDF: $USP_BDF"
> echo ""
> 
> # Remove the USP device
> echo 1 | sudo tee /sys/bus/pci/devices/0000:${USP_BDF}/remove
> 
> # Trigger SBR via Bridge Control register
> BRIDGE_CTL=$(sudo setpci -s ${ROOT_PORT_BDF} 0x3E.w)
> BRIDGE_CTL_RESET=$(printf "0x%04x" $((0x$BRIDGE_CTL | 0x0040)))
> 
> echo "Asserting Secondary Bus Reset..."
> sudo setpci -s ${ROOT_PORT_BDF} 0x3E.w=$BRIDGE_CTL_RESET
> sleep 1
> 
> echo "De-asserting Secondary Bus Reset..."
> sudo setpci -s ${ROOT_PORT_BDF} 0x3E.w=$BRIDGE_CTL
> sleep 2
> 
> # Rescan PCI bus
> echo 1 | sudo tee /sys/bus/pci/rescan


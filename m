Return-Path: <SRS0=2+6m=KO=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=2+6m=KO=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 30 Jul 2018 10:32:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rajat Jain <rajatja@google.com>, Keith Busch <keith.busch@intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mayurkumar.patel@intel.com,
	rajatxjain@gmail.com, Richard Hughes <rhughes@redhat.com>,
	Carlos Garnacho <cgarnach@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180730083210.GA9641@wunner.de>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 27, 2018 at 03:26:19PM -0500, Bjorn Helgaas wrote:
> The question is where those sysfs files should be.  Currently they are
> associated with the device at the *upstream* end of the link.  In the
> example above, they're associated with the Root Port:
> 
>   /sys/devices/pci0000:00/0000:00:1c.2/power/link_state
> 
> I don't know if that's the right place, or if they should be
> associated with the device at the *downstream* end of the link, i.e.,
> 04:00.0.  The downstream end might be better because:
> 
>   - It's easier to associate the downstream end with a device the user
>     cares about, e.g., a NIC, GPU, etc.  This is mostly a user-
>     interface issue.
> 
>   - A link can lead to a multi-function device, and the spec allows
>     those functions to have different ASPM settings (see PCIe r4.0,
>     sec 5.4.1).  With the sysfs files at the upstream end of the link,
>     we have no way to configure those functions individually.
> 
> Any thoughts?

Conceivably, could the downstream end not be enumerated at all?
(E.g. a hotplug or rescan is necessary for it to be enumerated?)

If so, the upstream end might be better because the ASPM settings
can be configured in advance, before the downstream end appears.

Thanks,

Lukas

Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE819B
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 07:26:43 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 968B8100D940E;
	Mon, 27 Nov 2023 16:26:41 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6B2F5290BE; Mon, 27 Nov 2023 16:26:41 +0100 (CET)
Date: Mon, 27 Nov 2023 16:26:41 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Vikram Sethi <vsethi@nvidia.com>, Krishna Thota <kthota@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	sagar.tv@gmail.com
Subject: Re: Race b/w pciehp and FirmwareFirst DPC->EDR flow - Reg
Message-ID: <20231127152641.GA5149@wunner.de>
References: <BN8PR12MB290002441CA3C24D1FA742D2B8AEA@BN8PR12MB2900.namprd12.prod.outlook.com>
 <529acc15-1932-4785-9edf-c5327db64ab1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529acc15-1932-4785-9edf-c5327db64ab1@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Vidya,

sorry for the delay, still catching up on e-mails after Plumbers...

On Fri, Nov 10, 2023 at 10:31:55PM +0530, Vidya Sagar wrote:
> > - System doesn't have support for in-band PD and supports only OOB PD
> >   where writing to a private register would set the PD state

We already have an inband_presence_disabled flag in struct controller
which is set if the In-Band PD Disable Supported bit in the Slot
Capabilities 2 Register is set.  The flag may also be set through the
inband_presence_disabled_dmi_table[].

Currently the only place where the flag makes a difference is on
slot bringup:  pciehp_check_link_status() doesn't wait for the
Presence Detect Status bit to become set.

I'm wondering if we need to also disregard PDC events if In-Band PD
is disabled.  Not sure if the behavior you're seeing is caused by a
quirk of the hardware or is expected if In-Band PD is disabled.
Probably the former.  A code change would generally only be acceptable
in the latter case though I think.


> > 10. Since PDC (Presence Detect Change) bit is also set for the first
> >     interrupt, IST attempts to remove the devices (as part of
> >     pciehp_handle_presence_or_link_change())
> > 
> > At this point, there is a race between the device driver that is
> > trying to work with the device (through pci_error_handlers callback)
> > and the IST that is trying to remove the device.
> > To be fair to pciehp_handle_presence_or_link_change(), after removing
> > the devices, it checks for the link-up/PD being '1' and scans the
> > devices again if the device is still available. But unfortunately,
> > IST is deadlocked (with the device driver) while removing the devices
> > itself and won't go to the next step.

Could you provide stacktraces of the two deadlocked tasks?
Right now I don't quite understand why they're deadlocked.

Are you getting hung task messages in dmesg?
They should include stacktraces.

Also, which kernel version are we talking about?

Thanks,

Lukas

Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nix <nix@esperi.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Boot <bootc@bootc.net>,
	"Wyborny\, Carolyn" <carolyn.wyborny@intel.com>,
	e1000-devel@lists.sourceforge.net, netdev <netdev@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Matthew Garrett <mjg@redhat.com>
Subject: Re: [E1000-devel] e1000e interface hang on 82574L
References: <4EFA4024.5000909@bootc.net>
	<FCF3184D-CE4F-471C-B66C-0F671795FD3C@bootc.net>
	<9BBC4E0CF881AA4299206E2E1412B626017762@ORSMSX102.amr.corp.intel.com>
	<4F048861.8070501@bootc.net> <4F12B42C.9030803@bootc.net>
	<9BBC4E0CF881AA4299206E2E1412B62621F0B1@ORSMSX102.amr.corp.intel.com>
	<4F144A76.3050703@bootc.net> <4F64B4E2.20208@bootc.net>
	<4F64CFCB.7060702@bootc.net>
	<9BBC4E0CF881AA4299206E2E1412B6260E512E0C@ORSMSX102.amr.corp.intel.com>
	<87r4wova0b.fsf@spindle.srvr.nix>
	<9BBC4E0CF881AA4299206E2E1412B6260E512FB9@ORSMSX102.amr.corp.intel.com>
	<87ehsov6ot.fsf@spindle.srvr.nix>
	<1590F833-7D40-42FE-8FA2-6DCCADF9C6B0@bootc.net>
	<CAErSpo4TJ-9NsD5QTpFi9fsnD9qHt7+Tr5jJHQPuS7vg6ghq_w@mail.gmail.com>
Date: Fri, 06 Apr 2012 17:04:46 +0100
In-Reply-To: <CAErSpo4TJ-9NsD5QTpFi9fsnD9qHt7+Tr5jJHQPuS7vg6ghq_w@mail.gmail.com>
	(Bjorn Helgaas's message of "Fri, 6 Apr 2012 06:12:58 -0600")
Message-ID: <87r4w0luch.fsf@spindle.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6 Apr 2012, Bjorn Helgaas outgrape:
> If I understand correctly, e1000e attempts to disable ASPM to work
> around an 82574L hardware erratum, but the PCI core either doesn't
> disable ASPM or it gets re-enabled somehow.

It gets re-enabled. If you explicitly do a setpci in the boot process to
turn ASPM off on the interface, after doing your 'ip link up' and routing
initialization, by the end of the boot process ASPM is back on again.

I speculate that the stabilization of the interface (as indicated by the
link-enabled message) has somehow flipped ASPM on, but I have no actual
evidence for when this re-enabling happens. I just know it does.

-- 
NULL && (void)

Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nix <nix@esperi.org.uk>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Chris Boot <bootc@bootc.net>,
	"Wyborny\, Carolyn" <carolyn.wyborny@intel.com>,
	e1000-devel@lists.sourceforge.net, netdev <netdev@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Matthew Garrett <mjg@redhat.com>
Subject: Re: [E1000-devel] e1000e interface hang on 82574L
References: <9BBC4E0CF881AA4299206E2E1412B62621F0B1@ORSMSX102.amr.corp.intel.com>
	<4F144A76.3050703@bootc.net> <4F64B4E2.20208@bootc.net>
	<4F64CFCB.7060702@bootc.net>
	<9BBC4E0CF881AA4299206E2E1412B6260E512E0C@ORSMSX102.amr.corp.intel.com>
	<87r4wova0b.fsf@spindle.srvr.nix>
	<9BBC4E0CF881AA4299206E2E1412B6260E512FB9@ORSMSX102.amr.corp.intel.com>
	<87ehsov6ot.fsf@spindle.srvr.nix>
	<1590F833-7D40-42FE-8FA2-6DCCADF9C6B0@bootc.net>
	<CAErSpo4TJ-9NsD5QTpFi9fsnD9qHt7+Tr5jJHQPuS7vg6ghq_w@mail.gmail.com>
	<20120406134144.GA22526@khazad-dum.debian.net>
Date: Fri, 06 Apr 2012 17:05:53 +0100
In-Reply-To: <20120406134144.GA22526@khazad-dum.debian.net> (Henrique de
	Moraes Holschuh's message of "Fri, 6 Apr 2012 10:41:44 -0300")
Message-ID: <87mx6oluam.fsf@spindle.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6 Apr 2012, Henrique de Moraes Holschuh outgrape:
> You probably need to disable it upstream of the 82574L as well.  Here
> (SuperMicro C7X58) I managed to get it to be stable by telling the BIOS
> to disable L0s and L1 system-wide.
>
> But not all BIOSes will have that option...

Indeed not :( the Tyan S7010 mobo in my headless server can't do it.

-- 
NULL && (void)

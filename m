Return-Path: <linux-kernel-owner@vger.kernel.org>
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add PCI ID and quirk for Intersil/Techwell TW686[4589] AV capture cards.
References: <m3vbekruuo.fsf@t19.piap.pl> <20150619221359.GN7710@google.com>
Date: Mon, 22 Jun 2015 07:35:44 +0200
In-Reply-To: <20150619221359.GN7710@google.com> (Bjorn Helgaas's message of
	"Fri, 19 Jun 2015 17:13:59 -0500")
Message-ID: <m3381ks3tb.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

>> Intersil/Techwell TW686[4589]-based video capture cards have an empty
>> (zero) class code. Fix it.
>> 
> Applied to pci/misc for v4.2, with minor tweak as below to use
> PCI_CLASS_MULTIMEDIA_OTHER instead of a bare number.  Let me know
> if you see any issues with this.  Thanks!

Can't see any, thanks a lot.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <SRS0=KDos=5V=suse.de=jdelvare@kernel.org>
Return-Path: <SRS0=KDos=5V=suse.de=jdelvare@kernel.org>
Message-ID: <1497619524.4126.5.camel@suse.de>
Subject: Re: dmi type 0xB1 record - unknown flag
From: Jean Delvare <jdelvare@suse.de>
To: Narendra.K@dell.com, helgaas@kernel.org
Cc: x86@kernel.org, linux-pci@vger.kernel.org, Jordan.Hargrave@dell.com,
	Shyam.Iyer@dell.com, bhelgaas@google.com
Date: Fri, 16 Jun 2017 15:25:24 +0200
In-Reply-To: <fb0d720dc6c441539fb5130d2628158f@BLRX13MDC105.AMER.DELL.COM>
References: <20170601143826.5f980444@endymion>
	 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
	 <20170602161311.27eab72d@endymion>
	 <20170615213935.GH12735@bhelgaas-glaptop.roam.corp.google.com>
	 <fb0d720dc6c441539fb5130d2628158f@BLRX13MDC105.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On ven., 2017-06-16 at 09:36 +0000, Narendra.K@dell.com wrote:
> Sorry for the delay. I applied the patch to the mainline kernel version 4.12-rc5 and performed sanity test on  a  DellEMC PowerEdge R730XD system. It is working as 
> expected.  'dmesg' shows the message that 'pci=bfsort' is enabled.
> 
> I also booted kernel version 4.12-rc5 with patch applied on a DellEMC PowerEdge 1950 system which is listed in the ' pciprobe_dmi_table' quicks table.
> It is working as expected and has not caused regression on this system. 'dmesg' shows the message that 'pci=bfsort' is enabled.

Thank you for testing it on real systems, this is very useful and
appreciated.

-- 
Jean Delvare
SUSE L3 Support

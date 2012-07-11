Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49360 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701Ab2GKON1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 10:13:27 -0400
Received: by pbbrp8 with SMTP id rp8so2067648pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 07:13:27 -0700 (PDT)
Message-ID: <4FFD89FC.9030905@gmail.com>
Date: Wed, 11 Jul 2012 22:13:16 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
CC: unlisted-recipients:; Yinghai Lu <yinghai@kernel.org>,
	linux-pci@vger.kernel.org, yhlu.kernel@gmail.com
Subject: Re: PICe hotplug problems
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>	<CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com> <OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>	<CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com> <OF9DA7C6E4.12BE1316-ONC1257A38.000618C1-C1257A38.00062838@transmode.se> <CAE9FiQVYt5sp9rQ1=L6ak4LJG1ot4WQ_nq8-t3qvmtpT_TRJLg@mail.gmail.com> <OF259177D8.B20ED592-ONC1257A38.00167C85-C1257A38.0016C890@LocalDomain> <OFA10FA4B6.A121C467-ONC1257A38.001BD265-C1257A38.001C3762@transmode.se>
In-Reply-To: <OFA10FA4B6.A121C467-ONC1257A38.001BD265-C1257A38.001C3762@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>> Thanks, that was really quick. However, the patches does not apply on my
>> 3.4 kernel and it looks non trivial to me fixup.
>>
>> Could you create (even quick and dirty) patches on top of 3.4?
> 
> I noted that the msi_bus for 0000:01:00.0 return nothing (cat msi_bus)
> If I cat it into a file and check the size it is zero.
> 
> Any idea what this is about:
>   cat vpd
>   cat: read error: Connection timed out
> 
> hmm, just saw this in dmesg:
>    pci 0000:01:00.0: vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update.
VPD stands for Vital Product Data, vendor may store product specific information
in VPD, such as "serial number" etc. It may depend on some micro-controller on
the PCI card to access those data. And VPD is optional, doesn't affect normal
PCI functionalities.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



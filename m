Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Feb 2013 06:35:09 +0000 (UTC)
From: "Artem S. Tashkinov" <t.artem@lycos.com>
To: bhelgaas@google.com
Cc: stern@rowland.harvard.edu, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rjw@sisk.pl
Message-ID: <337833384.57445.1361860509194.JavaMail.mail@webmail08>
References: <CAErSpo7qj2SNR7BfuBsfF-saZXvgcqqLtgoP5Hyb5u99qR4Ncg@mail.gmail.com>
 <Pine.LNX.4.44L0.1302191119270.2215-100000@iolanthe.rowland.org><CAErSpo7NZoOQZyW76HEoOTVgdqL2CgbVScAeF6HGLAVaNCq0=w@mail.gmail.com>
Subject: Re: Abysmal HDD/USB write speed after sleep on a UEFI system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Feb 26, 2013 03:57:52 AM, Bjorn Helgaas wrote:
>
>Where are we at with this, Artem?  I assume it's still a problem.
>

Yes, it is, Bjorn.

In order to eliminate this problem I switched back to MBR yesterday, because
so far I haven't received any instructions or guidance as to how I can debug
it further. I'm absolutely sure USB write speed is just another manifestation of
it so I decided not to debug USB specifically (it just doesn't make too much
sense).

What I see is that something terribly wrong is going on but if Linus has no ideas
I, as an average Joe, don't have a slightest clue as to what I can do.

The bug report with necessary, but seemingly useless information, can be 
found here: https://bugzilla.kernel.org/show_bug.cgi?id=53551

If anyone comes up with new ideas I can quickly try UEFI again now that I
have two HDDs at my disposal (the old one is formatted as GPT, the new one is
MBR).

Best regards,

Artem

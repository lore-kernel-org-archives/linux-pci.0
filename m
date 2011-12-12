Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49364 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1LLLzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2011 06:55:50 -0500
Received: by ghbf1 with SMTP id f1so897060ghb.19
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2011 03:55:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <loom.20111209T143404-436@post.gmane.org>
References: <AANLkTin7itjGUuyzFP2=NxGyvU2qv24Rt24wnNLEC+gN@mail.gmail.com>
	<20101021122526.GG2447@parisc-linux.org>
	<AANLkTinFpwRfKaN8W2R+F3-QnEA_ZMgGbcgXvpM+UyKZ@mail.gmail.com>
	<20101024055405.GC25607@lackof.org>
	<AANLkTimpBkGjVUGcuWp93swyyCPJ6OEYVD6UKmZ8yiS8@mail.gmail.com>
	<20101028044411.GA32200@lackof.org>
	<loom.20111209T143404-436@post.gmane.org>
Date: Mon, 12 Dec 2011 17:25:49 +0530
Message-ID: <CAHM4w1kHmng=r-OZ0=p1u0+f+C=cfN4OxT_7Bvun38rOwn5jSQ@mail.gmail.com>
Subject: Re: Problem in reading cfg space of device connected below a bridge
From: Pratyush Anand <pratyush.anand@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Well, today I got some conclusive observation.
Actually, the bridge which I connect does not have a device with
device number 0.
It has first device with device number 4.
So, I hardcoded in my linux code and sent a CFGRD1 with bus 2, dev 4,
and func 0. I was able to access its configuration space.
But my software aborts if I send request with bus 2, dev 0 and func 0.

Now my question is, is it the responsibilty of PCIe RC controller to
return 0xFFFF as VID if it receives an UR (unsupported request from
downstream device)
or,
is it the responsibilty of software to implement an appropriate abort
handler in this case?

Regards
Pratyush

On Fri, Dec 9, 2011 at 7:09 PM, Pratyush Anand <pratyush.anand@gmail.com> wrote:
> Grant Grundler <grundler <at> parisc-linux.org> writes:
>
> After a long time , I am back to this issue again. I have taken log from
> analyser, and I can see that my host controller is correctly generating cfgrd1.
> What could be wrong?
>
> This is text exported log of lecroy PCIe analyser.
>
> Packet(951428) Downstream 2.5(x1) TLP(97) Cfg
> _______| CfgWr0(10:00100) Length(1) RequesterID(002:00:0) Tag(0)
> _______| DeviceID(003:00:0) Register(0x018) 1st BE(1111)
> _______| Secondary Latency Timer(0x00) Subordinate Bus Number(0xFF)
> _______| Secondary Bus Number(0x04) Primary Bus Number(0x03) LCRC(0x564084DF)
> _______| Time Stamp(0047 . 793 106 288 s)
> _______|_______________________________________________________________________
> Filtered Traffic
> Packet(951429) Upstream 2.5(x1) TLP(96) Cpl Cpl(00:01010)
> _______| Length(0) RequesterID(002:00:0) Tag(0) CompleterID(003:00:0) Status
> (SC)
> _______| BCM(0) Byte Cnt(4) Lwr Addr(0x00) LCRC(0x502279E4)
> _______| Time Stamp(0047 . 793 106 552 s)
> _______|_______________________________________________________________________
> Filtered Traffic
> Packet(951430) Upstream 2.5(x1) DLLP ACK
> _______| AckNak_Seq_Num(97) CRC 16(0x1425) Time Stamp(0047 . 793 107 004 s)
> _______|_______________________________________________________________________
> Packet(951431) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(96)
> _______| CRC 16(0xB53E) Time Stamp(0047 . 793 108 056 s)
> _______|_______________________________________________________________________
> Filtered Traffic
> Packet(951432) Downstream 2.5(x1) TLP(98) Cfg
> _______| CfgRd1(00:00101) Length(1) RequesterID(002:00:0) Tag(1)
> _______| DeviceID(004:00:0) Register(0x000) 1st BE(1111) LCRC(0xDFA187B4)
> _______| Time Stamp(0047 . 793 110 456 s)
> _______|_______________________________________________________________________
> Filtered Traffic
> Packet(951433) Upstream 2.5(x1) TLP(97) Cpl Cpl(00:01010)
> _______| Length(0) RequesterID(002:00:0) Tag(1) CompleterID(004:00:0)
> _______| Status(UR)-BAD BCM(0) Byte Cnt(4) Lwr Addr(0x00) LCRC(0xBBC69D2D)
> _______| Time Stamp(0047 . 793 110 960 s)
> _______|_______________________________________________________________________
> Packet(951434) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(98) CRC 16(0xF709)
> _______| Time Stamp(0047 . 793 111 148 s)
> _______|_______________________________________________________________________
> Packet(951435) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(97)
> _______| CRC 16(0x1425) Time Stamp(0047 . 793 112 488 s)
> _______|______________________________________________________________________
>
>
> regards
> Pratyush
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

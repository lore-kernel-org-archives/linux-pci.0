Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33169 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab1LINpH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Dec 2011 08:45:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1RZ0l5-00017O-6J
	for linux-pci@vger.kernel.org; Fri, 09 Dec 2011 14:45:05 +0100
Received: from AES-Static-041.2.22.125.airtel.in ([AES-Static-041.2.22.125.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2011 14:45:03 +0100
Received: from pratyush.anand by AES-Static-041.2.22.125.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2011 14:45:03 +0100
To: linux-pci@vger.kernel.org
From: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: Problem in reading cfg space of device connected below a bridge
Date: Fri, 9 Dec 2011 13:39:04 +0000 (UTC)
Message-ID: <loom.20111209T143404-436@post.gmane.org>
References: <AANLkTin7itjGUuyzFP2=NxGyvU2qv24Rt24wnNLEC+gN@mail.gmail.com> <20101021122526.GG2447@parisc-linux.org> <AANLkTinFpwRfKaN8W2R+F3-QnEA_ZMgGbcgXvpM+UyKZ@mail.gmail.com> <20101024055405.GC25607@lackof.org> <AANLkTimpBkGjVUGcuWp93swyyCPJ6OEYVD6UKmZ8yiS8@mail.gmail.com> <20101028044411.GA32200@lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Grant Grundler <grundler <at> parisc-linux.org> writes:

After a long time , I am back to this issue again. I have taken log from 
analyser, and I can see that my host controller is correctly generating cfgrd1.
What could be wrong?

This is text exported log of lecroy PCIe analyser.

Packet(951428) Downstream 2.5(x1) TLP(97) Cfg 
_______| CfgWr0(10:00100) Length(1) RequesterID(002:00:0) Tag(0) 
_______| DeviceID(003:00:0) Register(0x018) 1st BE(1111) 
_______| Secondary Latency Timer(0x00) Subordinate Bus Number(0xFF) 
_______| Secondary Bus Number(0x04) Primary Bus Number(0x03) LCRC(0x564084DF) 
_______| Time Stamp(0047 . 793 106 288 s) 
_______|_______________________________________________________________________
Filtered Traffic 
Packet(951429) Upstream 2.5(x1) TLP(96) Cpl Cpl(00:01010) 
_______| Length(0) RequesterID(002:00:0) Tag(0) CompleterID(003:00:0) Status
(SC) 
_______| BCM(0) Byte Cnt(4) Lwr Addr(0x00) LCRC(0x502279E4) 
_______| Time Stamp(0047 . 793 106 552 s) 
_______|_______________________________________________________________________
Filtered Traffic 
Packet(951430) Upstream 2.5(x1) DLLP ACK 
_______| AckNak_Seq_Num(97) CRC 16(0x1425) Time Stamp(0047 . 793 107 004 s) 
_______|_______________________________________________________________________
Packet(951431) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(96) 
_______| CRC 16(0xB53E) Time Stamp(0047 . 793 108 056 s) 
_______|_______________________________________________________________________
Filtered Traffic 
Packet(951432) Downstream 2.5(x1) TLP(98) Cfg 
_______| CfgRd1(00:00101) Length(1) RequesterID(002:00:0) Tag(1) 
_______| DeviceID(004:00:0) Register(0x000) 1st BE(1111) LCRC(0xDFA187B4) 
_______| Time Stamp(0047 . 793 110 456 s) 
_______|_______________________________________________________________________
Filtered Traffic 
Packet(951433) Upstream 2.5(x1) TLP(97) Cpl Cpl(00:01010) 
_______| Length(0) RequesterID(002:00:0) Tag(1) CompleterID(004:00:0) 
_______| Status(UR)-BAD BCM(0) Byte Cnt(4) Lwr Addr(0x00) LCRC(0xBBC69D2D) 
_______| Time Stamp(0047 . 793 110 960 s) 
_______|_______________________________________________________________________
Packet(951434) Upstream 2.5(x1) DLLP ACK AckNak_Seq_Num(98) CRC 16(0xF709) 
_______| Time Stamp(0047 . 793 111 148 s) 
_______|_______________________________________________________________________
Packet(951435) Downstream 2.5(x1) DLLP ACK AckNak_Seq_Num(97) 
_______| CRC 16(0x1425) Time Stamp(0047 . 793 112 488 s) 
_______|______________________________________________________________________


regards
Pratyush


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.extricom.com ([212.235.17.194]:35796 "HELO
	smtp.extricom.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1751232Ab2HTII6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 04:08:58 -0400
Message-ID: <5031EA55.4030503@extricom.com>
Date: Mon, 20 Aug 2012 10:42:13 +0300
From: leonid <leonid@extricom.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: p4080DS board and myri10gi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi
This is my first mail in this group , so I hope this is the right place 
for it.

I am testing myri10ge pci-e (10G ethernet card) on p4080 evaluation board.
using kernel 2.6.34.6
when I am trying to insert myri10ge kernel module, I getting :
"myri10ge: Version 1.5.2-1.459
myri10ge 0001:03:00.0: invalid sram_size -33B or board span 16777216B "

it is looks like sram_size value is garbage read from the device .

any idea ?

reference:
myri10ge - https://www.myricom.com
p4080ds - 
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=P4080DS

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:46761 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894AbaJWQIx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Oct 2014 12:08:53 -0400
Message-ID: <54492606.5090308@maya.org>
Date: Thu, 23 Oct 2014 18:00:06 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org>		 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>		 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>		 <5437F1F5.3010706@maya.org>		 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>		 <543804BC.3080307@maya.org>		 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>		 <20141011003219.560cca97@dualc.maya.org>		 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>		 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>		 <1413925580.4202.189.camel@ul30vt.home>	 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org> <1414010215.4202.275.camel@ul30vt.home>
In-Reply-To: <1414010215.4202.275.camel@ul30vt.home>
Content-Type: multipart/mixed;
 boundary="------------080602080605010009070404"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080602080605010009070404
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alex Williamson wrote:
> On Wed, 2014-10-22 at 18:22 +0200, Andreas Hartmann wrote:
>> Alex Williamson wrote:
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3308,15 +3308,15 @@ static int __pci_dev_reset(struct pci_dev *dev, int prob
>>>         if (rc != -ENOTTY)
>>>                 goto done;
>>>  
>>> -       rc = pci_pm_reset(dev, probe);
>>> +       rc = pci_dev_reset_slot_function(dev, probe);
>>>         if (rc != -ENOTTY)
>>>                 goto done;
>>>  
>>> -       rc = pci_dev_reset_slot_function(dev, probe);
>>> +       rc = pci_parent_bus_reset(dev, probe);
>>>         if (rc != -ENOTTY)
>>>                 goto done;
>>>  
>>> -       rc = pci_parent_bus_reset(dev, probe);
>>> +       rc = pci_pm_reset(dev, probe);
>>>  done:
>>>         return rc;
>>>  }
>>
>> This way it's crashing with echo 1 > reset, too.
> 
> Ok, so it's somehow related to doing a bus reset with virtual channel
> save/restore while PM reset with VC save/restore works ok as apparently
> does bus reset without VC save/restore.  Let's try to do a manual bus
> reset so we can look at the post reset state of the device before the
> kernel tries to restore it.
> 
> First bind the target device 03:00.0 to pci-stub or vfio-pci so that we
> know it's not being used.
> 
> Next capture lspci -xxxx -s 3:00.0 so we have the starting state.
> 
> Then we'll do a bus reset using setpci:
> # setpci -s 00:05.0 3e.w=40:40
> <if you script this, wait at least 2ms here>
> # setpci -s 00:05.0 3e.w=00:40
> <wait 1 second here>
> 
> Now re-capture lspci -xxxx -s 3:00.0

The machine is booted w/ vfio bound to 3:00.0 as usual (now for testing
linux 3.14)

lspci -xxxx -s 3:00.0
setpci -s 00:05.0 3e.w=40:40
usleep 10
setpci -s 00:05.0 3e.w=00:40
sleep 1
lspci -xxxx -s 3:00.0

I didn't get the second lspci because the machine already was hanging.
The first output is attached completely.



Hope this helps,
thanks,
regards,
Andreas

--------------080602080605010009070404
Content-Type: application/x-gzip;
 name="atheros-pci1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="atheros-pci1.gz"

H4sICBMlSVQAA2F0aGVyb3MtcGNpMQCN2suO0zAYhuF9rgQ2yOdDd3MDSLBh7aNAdCjqFJjL
x26qaeeQ0etFk1afbCd95OZvIvROiE/iczv9Oxx/lsOv0/Gw37fj7suftC+H+/u70/d2PDzc
fY368fHbj2Pbt4eHS/yupt+ndvxwbH+F/LgIsQtFOi1G80LIuR0vQQh13h9tkWInjBC59Co2
2qJGZqPN/qXSctHXjHkZsuvQixkZaUXRNm+OZUfGehGMkJsZtz2fp4wXu3MH6jxLr4qQcr6J
4xRIW8Q4KUsQuzlXKTeHEku8jrWVWhKYTwaZAjIVZBrIdJAZB7w7H7WUr75TPU+mm6EpaD3N
4rp92dM7hK4hTUIT0RxF6ndC9tpT7/M1vBEijKQnoUBCkYQIJUksSYJJEk2ScJLEkxIkJEmI
eFLEkzIkZEmIeFLEkyKeFPGkiCdFPCniSRFPinhSxJOenuYysL1+jxDxpIknTTxp4kkTT5p4
0sSTJp408aSJJ008aeJJE0+aeNLEkyHrkyGeDPFkiCdDPBniyRBPhngyxJMhngzxZIgnQzwZ
4skQT4Z4ssSTJZ4s8WSJJ0s8WeLJEk+WeLLEkyWeLPFkiSdLPFniyRJPlnhyxJMjnhzx5Ign
Rzw54skRT454csSTI54c8eSIJ0c8OeLJEU+OePLDkx+oxhct+6Vdqnc/6quuu/SLH57UvMS6
uchKKZyrr3Ap+BZ/6+lSmNlRZvtRaMv1+iwsXq/19nw7Burr9rx3M6fp6eaDcwtmHUev28Vf
PL2u6m57Qn8TEE+eePLEk3/D07iyfnYkiyeePPHkiSdPPHniKby/Pq1/AoXh6QnbtT2r5pdA
1qdA1qdA1qdA1qdAPAXiKRBPgXgKZH0KxFMgngLxFIinQDxF8nsXye9dJJ4i8RSJp0g8ReIp
Ek+ReIrEUySeIvEUiadIPEXiKRJPiXhKxFMinhLxlIinRDwl4ikRT4l4SsRTIp4S8ZSIp0Q8
JeIpEU+ZeMrEUyaeMvGUiadMPGXiKRNPmXjKxFNGt1qIp0w8ZeIpE0+ZeCrEUyGeCvFUiKdC
PBXiqRBPhXgqxFMhngrxVNC9O+KpEE+FeCrEUyWeKvFUiadKPFXiqRJPlXiqxFMlnirxVImn
SjxVdDOYeKrEUyWeGvHUiKdGPDXiqRFPjXhqxFMjnhrx1IinRjw14qkRTw09XUA8NeKpE0+d
eOrEUyeeOvHUiadOPHXiqRNPnXjqxFMnnjrx1Imnjh5XIZ7+AyFK1lk8JQAA
--------------080602080605010009070404--

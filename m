Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:34131 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbaJ2Via (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Oct 2014 17:38:30 -0400
Message-ID: <54515D96.40007@maya.org>
Date: Wed, 29 Oct 2014 22:35:18 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org>								 <543804BC.3080307@maya.org>								 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>								 <20141011003219.560cca97@dualc.maya.org>								 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>								 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>								 <1413925580.4202.189.camel@ul30vt.home>							 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>						 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org>					 <1414082022.27420.39.camel@ul30vt.home> <54493BFA.8010609@maya.org>				 <1414093023.27420.40.camel@ul30vt.home> <544B3D14.70907@maya.org>			 <1414533068.27420.226.camel@ul30vt.home> <54511A16.30602@maya.org>		 <1414604677.27420.263.camel@ul30vt.home> <54512A91.2010606@maya.org>	 <1414606581.27420.266.camel@ul30vt.home>	 <20141029204344.61d5fc73@dualc.maya.org> <1414615824.27420.281.camel@ul30vt.home>
In-Reply-To: <1414615824.27420.281.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:

[...] more tomorrow

> In the "working" case with Bjorn's patch, are you actually trying to use
> the device or just testing to see if the system survives reset? 

The VM starts hostapd using this device. Hostapd didn't show any error
in the logfile using this device. Therefore I think it should have worked:

1414609514.733245: Using interface wlan1 with hwaddr 64:70:02:... and
ssid "..."

1414609514.766353: wlan1: interface state HT_SCAN->ENABLED
1414609514.766380: wlan1: AP-ENABLED


Regards,
Andreas

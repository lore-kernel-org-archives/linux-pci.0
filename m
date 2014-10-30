Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:43783 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161172AbaJ3U1e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 16:27:34 -0400
Message-ID: <54529DC8.30103@maya.org>
Date: Thu, 30 Oct 2014 21:21:28 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org>										 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>										 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>										 <1413925580.4202.189.camel@ul30vt.home>									 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>								 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org>							 <1414082022.27420.39.camel@ul30vt.home> <54493BFA.8010609@maya.org>						 <1414093023.27420.40.camel@ul30vt.home> <544B3D14.70907@maya.org>					 <1414533068.27420.226.camel@ul30vt.home> <54511A16.30602@maya.org>				 <1414604677.27420.263.camel@ul30vt.home> <54512A91.2010606@maya.org>			 <1414606581.27420.266.camel@ul30vt.home>			 <20141029204344.61d5fc73@dualc.maya.org>		 <1414615824.27420.281.camel@ul30vt.home> <545268E8.3080107@maya.org>	 <1414688299.27420.292.camel@ul30vt.home>	 <20141030200922.15126d7a@dualc.maya.org> <1414698349.27420.302.camel@ul30vt.home>
In-Reply-To: <1414698349.27420.302.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:
> On Thu, 2014-10-30 at 20:09 +0100, Andreas Hartmann wrote:
[...]
>> Well, but what to do now? I know how to "fix" it. But this means I have
>> to compile my kernels again on my own if it is >= 3.14.
> 
> Let's not give up hope just yet, I'd like to try another bus reset
> mechanism with setpci.  Install the Atheros card and bind it to
> pci-stub, then do:
> 
> setpci -s 00:05.0 68.w=0010:0010
> sleep 0.1
> setpci -s 00:05.0 68.w=0000:0010
> sleep 1
> lspci -xxx -s 3:00.0

Exactly same -> hang :-(.


Thanks,
Regards,
Andreas

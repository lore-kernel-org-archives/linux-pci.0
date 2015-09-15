Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:4789
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751612AbbIOX37 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 19:29:59 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH v2 06/12] drivers:hv: Export do_hypercall()
Date: Tue, 15 Sep 2015 23:29:56 +0000
Message-ID: <DM2PR0301MB1232E4E3EBC38F914E4B500EAB5C0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
 <1441929670-10058-7-git-send-email-jakeo@microsoft.com>
 <BY2PR0301MB165498EE3FC07D57AE99A984A05C0@BY2PR0301MB1654.namprd03.prod.outlook.com>
In-Reply-To: <BY2PR0301MB165498EE3FC07D57AE99A984A05C0@BY2PR0301MB1654.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > ---
> > @@ -91,7 +91,7 @@ static int query_hypervisor_info(void)
> >  /*
> >   * do_hypercall- Invoke the specified hypercall
> >   */
> > -static u64 do_hypercall(u64 control, void *input, void *output)
> > +u64 do_hypercall(u64 control, void *input, void *output)
> 
> do_hypercall() is not an appropriate name for a function to be exported. I
> plan to take the base
> vmbus patches through Greg's tree and if it is ok with you, I will change the
> name of this function.
> 
> Regards,
> 
> K. Y

Of course.  Thanks.

-- Jake Oshins


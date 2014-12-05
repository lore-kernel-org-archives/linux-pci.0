Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39833 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbaLELw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Dec 2014 06:52:29 -0500
Message-ID: <1417777177.4741.69.camel@kernel.crashing.org>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?ISO-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	weiyang@linux.vnet.ibm.com
Date: Fri, 05 Dec 2014 21:59:37 +1100
In-Reply-To: <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	 <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
	 <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
	 <20141204173411.GA5949@google.com>
	 <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-12-04 at 14:06 -0800, Yinghai Lu wrote:
> > I'm considering reverting 5b28541552ef (assuming that would fix this radeon
> > regression) because I think the radeon problem is worse than the 74151
> > problem and I think we can solve 74151 in a different way.
> >
> > Guo, Ben, this would affect you!  It's too late to revert 5b28541552ef for
> > v3.18, but we really need to work on this for v3.19.
> >
> > FOr 85491 (the radeon problem), we might be able to work around it by
> > fixing the bridge window, but I'm not sure we could even get that done
> > before v3.18.  I'll work on that today.
> 
> shrink bridge mmio pref range instead of reject it?

Guo unfortunately doesn't work for us anymore. Gavin, Richard, can
you handle this please ?

Cheers,
Ben.



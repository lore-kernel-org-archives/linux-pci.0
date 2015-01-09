Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37361 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbAIUiv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 15:38:51 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so16998412ier.13
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2015 12:38:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150109184549.GI6575@google.com>
References: <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
	<20141220002306.GB30834@google.com>
	<CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
	<CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
	<CAE9FiQV6nxeMcLQ6YBR_c5tNGGjiKgL+Z4vcGpK21j-14V8SKw@mail.gmail.com>
	<CAE9FiQVggbU5u__0z8p33J9hQ39CtQ-vpQbZyjG-LO9aqN05Lw@mail.gmail.com>
	<20141223214106.GA27291@google.com>
	<CAE9FiQUoA_vz78sEnHtDAmzTJcwL0PdUe9jwLw+H9h3+omq+WA@mail.gmail.com>
	<549C313A.7090504@gmail.com>
	<CAE9FiQUihEJeMT98pF-eQTEY9NcvvBCUgWQKXVXwmCZ8=Jy=8Q@mail.gmail.com>
	<20150109184549.GI6575@google.com>
Date: Fri, 9 Jan 2015 12:38:50 -0800
Message-ID: <CAE9FiQXCv0q0+K1Z54opUDRL2ofRGYsbh5-OYwDXis7pZFa8Kw@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 9, 2015 at 10:45 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Dec 25, 2014 at 01:12:47PM -0800, Yinghai Lu wrote:
> Do we have a patch that fixes the problem on x86?  I see that v2 failed for
> Marek, and I don't see any test results for v3.


Yes. v3 works for Marek.

>
> Also, my intent is for Marek or others to test this and verify that it
> works on x86, and then you extend the patch to cover all architectures, and
> then I'll merge them all.  I do not intend to merge the x86 change by
> itself before the changes to other arches, because if I do that, the other
> arches will probably never get fixed.

Ok, will go over other arch that ...

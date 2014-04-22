Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:63703 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaDVQIm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Apr 2014 12:08:42 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so5946923obc.35
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2014 09:08:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo526WATQKU9DZ4YjTTL9ot_1soGnjcs=ipgyqt2XNQ-fA@mail.gmail.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
 <1397000541-1085-2-git-send-email-keith.busch@intel.com> <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com>
 <alpine.LRH.2.03.1404211935510.5490@AMR> <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
 <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com>
 <B8DB29EA17EB2742AC3405C31A9B9EE961457B96@ORSMSX111.amr.corp.intel.com>
 <CAP8+hKV_-OqAOWHC2tZqYmt1O9pjTtauXECU=R+48rb0A3EfQA@mail.gmail.com>
 <7174f4a8.23ad7.14589360cb2.Coremail.liaohengquan1986@163.com> <CAErSpo526WATQKU9DZ4YjTTL9ot_1soGnjcs=ipgyqt2XNQ-fA@mail.gmail.com>
From: Learner Study <learner.study@gmail.com>
Date: Tue, 22 Apr 2014 09:08:22 -0700
Message-ID: <CAP8+hKVH3CBLfrLq2CgSLrr34jkxh4Dv5iC8UJ2QzfBMW8iQnw@mail.gmail.com>
Subject: Re: Wheather the NVMe driver has been tried on the IBM or Lenovo server?
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: liaohengquan1986 <liaohengquan1986@163.com>,
	"Mayes, Barrett N" <barrett.n.mayes@intel.com>,
	"Busch, Keith" <keith.busch@intel.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'd like to test out the latest NVMe driver. Could someone recommend a
NVMe controller should I use? I haven't been  able to find anything on
Amazon yet...

And perhaps, which version of kernel (OS distribution) should I pick?

Thanks


On Tue, Apr 22, 2014 at 8:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Apr 22, 2014 at 5:33 AM, liaohengquan1986
> <liaohengquan1986@163.com> wrote:
>>
>> Hi, everyone,
>>             I want to ask that weather the NVMe driver has been tried on the
>> IBM or Lenovo server?
>>             I use it on IBM(Lenovo) server with suse 11 SP3, but the MSI-X
>> irq is always could not be got by cpu(may be it is masked).
>>             Has anyone got this kind of problem?
>
> I think your original email contained non-plain text, so it won't
> appear on the mailing list, and some recipients may auto-discard it as
> well.  See http://vger.kernel.org/majordomo-info.html
>
> If you can reproduce the problem with an upstream kernel, this is the
> right place to debug it.  We'd need a complete dmesg log and "lspci
> -vv" output to start with.
>
> If the problem only happens with SUSE, then you'd want to work with
> SUSE to figure it out.
>
> Bjorn

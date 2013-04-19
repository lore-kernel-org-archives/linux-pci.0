Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:18175 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab3DSVF7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 17:05:59 -0400
Message-ID: <1366405557.9609.122.camel@gandalf.local.home>
Subject: Re: "unsigned expression < 0" always false warning
From: Steven Rostedt <rostedt@goodmis.org>
To: Gary Hade <garyhade@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lance Ortiz <lance.ortiz@hp.com>
Date: Fri, 19 Apr 2013 17:05:57 -0400
In-Reply-To: <20130419204304.GA28603@us.ibm.com>
References: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
	 <20130419204304.GA28603@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-04-19 at 13:43 -0700, Gary Hade wrote:

> The above
>   "__field(        u32,            status          )"
> gets expanded to
>   "ret = trace_define_field(event_call, "u32", "status", __builtin_offsetof(typeof(field),status), sizeof(field.status), (((u32)(-1)) < (u32)0), FILTER_OTHER); if (ret) return ret;"
> 
> The warning is triggered by:
>   "(((u32)(-1)) < (u32)0)"
> which was put there by is_signed_type.
> 
> It appears that is_signed_type is simply taking advantage of the same
> action that the compiler is warning about to perform it's function.

Yeah, that's the point of the macro.

> 
> Not sure how to make is_signed_type warningless although
> it does create a significant amount of noise during a full
> `make W=1` kernel build.  With 3.9-rc7 it appears to be
> responsible for 1401 of 1476 occurrences of "warning: comparison
> of unsigned expression < 0 is always false".

Since it is complaining about being less than zero, I just checked, the
following also works.

#define is_signed_type(type) ((type)-1 < (type)1)

And doesn't give the warning.

I'll go make a patch.

Thanks!

-- Steve



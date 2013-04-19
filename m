Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:59602 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab3DSUnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Apr 2013 16:43:16 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <garyhade@us.ibm.com>;
	Fri, 19 Apr 2013 16:43:15 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E5A7F38C8042
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 16:43:12 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3JKh7Gj360630
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 16:43:07 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3JKh6Wv002621
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 14:43:07 -0600
Date: Fri, 19 Apr 2013 13:43:04 -0700
From: Gary Hade <garyhade@us.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lance Ortiz <lance.ortiz@hp.com>
Subject: Re: "unsigned expression < 0" always false warning
Message-ID: <20130419204304.GA28603@us.ibm.com>
References: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 15, 2013 at 11:17:31AM -0600, Bjorn Helgaas wrote:
> Can somebody help me resolve the following warning, please?
> 
> $ make W=1 drivers/pci/pcie/aer/aerdrv_errprint.o
> ...
>   CC      drivers/pci/pcie/aer/aerdrv_errprint.o
> In file included from include/trace/ftrace.h:356:0,
>                  from include/trace/define_trace.h:86,
>                  from include/trace/events/ras.h:77,
>                  from drivers/pci/pcie/aer/aerdrv_errprint.c:27:
> include/trace/events/ras.h: In function ‘ftrace_define_fields_aer_event’:
> include/trace/events/ras.h:72:1: warning: comparison of unsigned
> expression < 0 is always false [-Wtype-limits]
> 
> I think it's related to "status" being a u32 below (this is from
> include/trace/events/ras.h), but I don't know whether that's incorrect
> or how to fix it:
> 
> TRACE_EVENT(aer_event,
>         TP_PROTO(const char *dev_name,
>                  const u32 status,
>                  const u8 severity),
> 
>         TP_ARGS(dev_name, status, severity),
> 
>         TP_STRUCT__entry(
>                 __string(       dev_name,       dev_name        )
>                 __field(        u32,            status          )
>                 __field(        u8,             severity        )
>         ),
>         ...

The culrpit is the is_signed_type macro defined in
include/linux/ftrace_event.h:
  #define is_signed_type(type)    (((type)(-1)) < (type)0)

The above
  "__field(        u32,            status          )"
gets expanded to
  "ret = trace_define_field(event_call, "u32", "status", __builtin_offsetof(typeof(field),status), sizeof(field.status), (((u32)(-1)) < (u32)0), FILTER_OTHER); if (ret) return ret;"

The warning is triggered by:
  "(((u32)(-1)) < (u32)0)"
which was put there by is_signed_type.

It appears that is_signed_type is simply taking advantage of the same
action that the compiler is warning about to perform it's function.

Not sure how to make is_signed_type warningless although
it does create a significant amount of noise during a full
`make W=1` kernel build.  With 3.9-rc7 it appears to be
responsible for 1401 of 1476 occurrences of "warning: comparison
of unsigned expression < 0 is always false".

Gary


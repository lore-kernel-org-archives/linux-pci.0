Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:53411 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933977Ab3DSWqJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 18:46:09 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <garyhade@us.ibm.com>;
	Fri, 19 Apr 2013 16:46:06 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 669E119D8036
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 16:45:48 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3JMjr1I133632
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 16:45:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3JMjqKg019146
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 16:45:53 -0600
Date: Fri, 19 Apr 2013 15:45:50 -0700
From: Gary Hade <garyhade@us.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lance Ortiz <lance.ortiz@hp.com>,
	Gary Hade <garyhade@us.ibm.com>
Subject: Re: "unsigned expression < 0" always false warning
Message-ID: <20130419224550.GA10898@us.ibm.com>
References: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
 <1366406262.9609.123.camel@gandalf.local.home>
 <CAErSpo7TgvkqcPk-aAJvY17yacDZcPjRLFxoNzf48_p3Jis7LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7TgvkqcPk-aAJvY17yacDZcPjRLFxoNzf48_p3Jis7LQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 19, 2013 at 04:30:14PM -0600, Bjorn Helgaas wrote:
> On Fri, Apr 19, 2013 at 3:17 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Does this fix your issue?
> 
> Yep, that fixes the warning for me.  Thanks!
> 
> Bjorn

It also worked for me.  It got rid of every one the 1401 is_signed_type
associated "warning: comparison of unsigned expression < 0 is always false"
occurrences (during 3.9-rc7 `make W=1` kernel build) mentioned in my
previous email.

Gary

> 
> > From d2802d0739dcc61af5e5ea00773ce7ddead4e9c2 Mon Sep 17 00:00:00 2001
> > From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> > Date: Fri, 19 Apr 2013 17:10:27 -0400
> > Subject: [PATCH] tracing: Compare to 1 instead of zero for is_signed_type()
> >
> > The formats of the trace events show if the type of a event field
> > is signed or not via a macro called is_signed_type(). This does
> > a trick with the type and compares a -1 to zero after typecasting
> > to the tested type. If it returns true, it's signed, otherwise
> > its not. But this unfortunately triggers a warning by gcc:
> >
> >   warning: comparison of unsigned expression < 0 is always false
> >
> > As we know it is always false (that's why we do it), this is a
> > false warning. Luckily for us, the comparison works with a 1 as
> > well, without giving the warning.
> >
> > Convert the check to compare (type)-1 < (type)0 to (type)-1 < (type)1
> > to determine if the type is signed or not.
> >
> > Link: http://lkml.kernel.org/r/CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com
> >
> > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reported-by: Gary Hade <garyhade@us.ibm.com>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  include/linux/ftrace_event.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
> > index 4e28b01..34e00fb 100644
> > --- a/include/linux/ftrace_event.h
> > +++ b/include/linux/ftrace_event.h
> > @@ -333,7 +333,7 @@ extern int trace_define_field(struct ftrace_event_call *call, const char *type,
> >  extern int trace_add_event_call(struct ftrace_event_call *call);
> >  extern void trace_remove_event_call(struct ftrace_event_call *call);
> >
> > -#define is_signed_type(type)   (((type)(-1)) < (type)0)
> > +#define is_signed_type(type)   (((type)(-1)) < (type)1)
> >
> >  int trace_set_clr_event(const char *system, const char *event, int set);
> >
> > --
> > 1.7.10.4
> >
> >
> >
> 


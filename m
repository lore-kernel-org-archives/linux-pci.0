Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:46948 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933870Ab3DSWaf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 18:30:35 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so3932767obc.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 15:30:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1366406262.9609.123.camel@gandalf.local.home>
References: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
 <1366406262.9609.123.camel@gandalf.local.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Apr 2013 16:30:14 -0600
Message-ID: <CAErSpo7TgvkqcPk-aAJvY17yacDZcPjRLFxoNzf48_p3Jis7LQ@mail.gmail.com>
Subject: Re: "unsigned expression < 0" always false warning
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lance Ortiz <lance.ortiz@hp.com>,
	Gary Hade <garyhade@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 19, 2013 at 3:17 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> Does this fix your issue?

Yep, that fixes the warning for me.  Thanks!

Bjorn

> From d2802d0739dcc61af5e5ea00773ce7ddead4e9c2 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> Date: Fri, 19 Apr 2013 17:10:27 -0400
> Subject: [PATCH] tracing: Compare to 1 instead of zero for is_signed_type()
>
> The formats of the trace events show if the type of a event field
> is signed or not via a macro called is_signed_type(). This does
> a trick with the type and compares a -1 to zero after typecasting
> to the tested type. If it returns true, it's signed, otherwise
> its not. But this unfortunately triggers a warning by gcc:
>
>   warning: comparison of unsigned expression < 0 is always false
>
> As we know it is always false (that's why we do it), this is a
> false warning. Luckily for us, the comparison works with a 1 as
> well, without giving the warning.
>
> Convert the check to compare (type)-1 < (type)0 to (type)-1 < (type)1
> to determine if the type is signed or not.
>
> Link: http://lkml.kernel.org/r/CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com
>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Reported-by: Gary Hade <garyhade@us.ibm.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/ftrace_event.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
> index 4e28b01..34e00fb 100644
> --- a/include/linux/ftrace_event.h
> +++ b/include/linux/ftrace_event.h
> @@ -333,7 +333,7 @@ extern int trace_define_field(struct ftrace_event_call *call, const char *type,
>  extern int trace_add_event_call(struct ftrace_event_call *call);
>  extern void trace_remove_event_call(struct ftrace_event_call *call);
>
> -#define is_signed_type(type)   (((type)(-1)) < (type)0)
> +#define is_signed_type(type)   (((type)(-1)) < (type)1)
>
>  int trace_set_clr_event(const char *system, const char *event, int set);
>
> --
> 1.7.10.4
>
>
>

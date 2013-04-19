Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4239 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab3DSVRo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 17:17:44 -0400
Message-ID: <1366406262.9609.123.camel@gandalf.local.home>
Subject: Re: "unsigned expression < 0" always false warning
From: Steven Rostedt <rostedt@goodmis.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lance Ortiz <lance.ortiz@hp.com>,
	Gary Hade <garyhade@us.ibm.com>
Date: Fri, 19 Apr 2013 17:17:42 -0400
In-Reply-To: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
References: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Does this fix your issue?

-- Steve

>From d2802d0739dcc61af5e5ea00773ce7ddead4e9c2 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
Date: Fri, 19 Apr 2013 17:10:27 -0400
Subject: [PATCH] tracing: Compare to 1 instead of zero for is_signed_type()

The formats of the trace events show if the type of a event field
is signed or not via a macro called is_signed_type(). This does
a trick with the type and compares a -1 to zero after typecasting
to the tested type. If it returns true, it's signed, otherwise
its not. But this unfortunately triggers a warning by gcc:

  warning: comparison of unsigned expression < 0 is always false

As we know it is always false (that's why we do it), this is a
false warning. Luckily for us, the comparison works with a 1 as
well, without giving the warning.

Convert the check to compare (type)-1 < (type)0 to (type)-1 < (type)1
to determine if the type is signed or not.

Link: http://lkml.kernel.org/r/CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Reported-by: Gary Hade <garyhade@us.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace_event.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
index 4e28b01..34e00fb 100644
--- a/include/linux/ftrace_event.h
+++ b/include/linux/ftrace_event.h
@@ -333,7 +333,7 @@ extern int trace_define_field(struct ftrace_event_call *call, const char *type,
 extern int trace_add_event_call(struct ftrace_event_call *call);
 extern void trace_remove_event_call(struct ftrace_event_call *call);
 
-#define is_signed_type(type)	(((type)(-1)) < (type)0)
+#define is_signed_type(type)	(((type)(-1)) < (type)1)
 
 int trace_set_clr_event(const char *system, const char *event, int set);
 
-- 
1.7.10.4




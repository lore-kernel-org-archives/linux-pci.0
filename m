Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:64808 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361Ab3DORRx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 13:17:53 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so4695777oag.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2013 10:17:53 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 15 Apr 2013 11:17:31 -0600
Message-ID: <CAErSpo4YXcY9fuOKWYGDkddJwk68kmZTohsmVB6QvrhjboOh1Q@mail.gmail.com>
Subject: "unsigned expression < 0" always false warning
To: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lance Ortiz <lance.ortiz@hp.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Can somebody help me resolve the following warning, please?

$ make W=1 drivers/pci/pcie/aer/aerdrv_errprint.o
...
  CC      drivers/pci/pcie/aer/aerdrv_errprint.o
In file included from include/trace/ftrace.h:356:0,
                 from include/trace/define_trace.h:86,
                 from include/trace/events/ras.h:77,
                 from drivers/pci/pcie/aer/aerdrv_errprint.c:27:
include/trace/events/ras.h: In function ‘ftrace_define_fields_aer_event’:
include/trace/events/ras.h:72:1: warning: comparison of unsigned
expression < 0 is always false [-Wtype-limits]

I think it's related to "status" being a u32 below (this is from
include/trace/events/ras.h), but I don't know whether that's incorrect
or how to fix it:

TRACE_EVENT(aer_event,
        TP_PROTO(const char *dev_name,
                 const u32 status,
                 const u8 severity),

        TP_ARGS(dev_name, status, severity),

        TP_STRUCT__entry(
                __string(       dev_name,       dev_name        )
                __field(        u32,            status          )
                __field(        u8,             severity        )
        ),
        ...

Thanks,
  Bjorn

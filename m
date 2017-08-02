Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37599 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbdHBRCT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 13:02:19 -0400
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@dell.com>
Cc: linux-ntb@googlegroups.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-15-logang@deltatee.com> <20170801191050.GJ4186@kudzu.us>
 <dda576ad-d3ca-814b-f0cf-478cbb61adf2@deltatee.com>
 <000001d30b90$31697f70$943c7e50$@dell.com>
 <CAPoiz9wy3bFUWkE1udiY7ynkOT5VxvvtoawNw1qRTFnSapcOEQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <95cd95ef-cd83-bd31-ddcb-1fcc0f7fbe51@deltatee.com>
Date: Wed, 2 Aug 2017 11:02:06 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9wy3bFUWkE1udiY7ynkOT5VxvvtoawNw1qRTFnSapcOEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 14/16] switchtec_ntb: implement scratchpad registers
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02/08/17 10:32 AM, Jon Mason wrote:
> After a long-ish conversation on IRC, the way we want to go forward
> would be to provide 2 ways of communicating prior to the MW's being
> setup:  SPADs and Message Registers.  The HW driver would make
> available whichever ones are supported by the hardware.  The transport
> can see which of those are available in the HW driver, select the
> appropriate one, and use it to setup the NTB connection, MW, etc.
> similar to how the SPADs are being used today.  This would allow for
> any current clients to work unmodified, and would require minimal
> changes to the existing transport layer.

I'm open to this, but I have a couple points:

1) I think there needs to be an ntb library or similar so the client
just has to say "communicate this setup data to the peer X". We don't
need every client replicating the decision to use spads or msgs or whatever.

2) In my experience, message registers are a bit of a pain to send
chunks of data like is being done with spads in the existing clients.
(Some time ago, I originally tried emulating spads with message
registers and it did not work well.)  You can only send 32bits at a time
and you have to have a signal indicating the other side is finished with
it before sending another message. I think they are best used just for
signaling infrequent events where if you loose a message it's not an issue.

One thought I had was that maybe we need to just push this decision into
the drivers. ie if there's an ntb api just for communicating setup data,
the driver could then determine the most appropriate way to communicate
it for the hardware (whether via spads, messages or a special memory
window). However, the difficulty with this is that the driver would have
to communicate if it's using spad resources it would otherwise advertise
to the clients.

Though, maybe we don't need spads in the ntb api. Maybe they are the
wrong abstraction. All the existing clients only use them for setup
data, so if we dropped the spad api in favor of a setup data api, the
driver could then just make the decision on how best to communicate it.

Anyway, just my thoughts.

Logan

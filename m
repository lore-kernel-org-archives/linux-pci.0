Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40756 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeEVWwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 18:52:05 -0400
Subject: Re: [PATCH 5/5] Documentation/PCI: Add details of PCI AER statistics
To: Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-6-rajatja@google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <cffe5b81-a05c-a249-8c36-70a9c4d61e7f@gmail.com>
Date: Tue, 22 May 2018 17:52:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180522222805.80314-6-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2018 05:28 PM, Rajat Jain wrote:
> Add the PCI AER statistics details to
> Documentation/PCI/pcieaer-howto.txt
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  Documentation/PCI/pcieaer-howto.txt | 35 +++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
> index acd0dddd6bb8..86ee9f9ff5e1 100644
> --- a/Documentation/PCI/pcieaer-howto.txt
> +++ b/Documentation/PCI/pcieaer-howto.txt
> @@ -73,6 +73,41 @@ In the example, 'Requester ID' means the ID of the device who sends
>  the error message to root port. Pls. refer to pci express specs for
>  other fields.
>  
> +2.4 AER statistics
> +
> +When AER messages are captured, the statistics are exposed via the following
> +sysfs attributes under the "aer_stats" folder for the device:
> +
> +2.4.1 Device sysfs Attributes
> +
> +These attributes show up under all the devices that are AER capable. These
> +indicate the errors "as seen by the device". Note that this may mean that if
> +an end point is causing problems, the AER counters may increment at its link
> +partner (e.g. root port) because the errors will be "seen" by the link partner
> +and not the the problematic end point itself (which may report all counters
> +as 0 as it never saw any problems).

I was afraid of that. Is there a way to look at the requester ID to log
AER errors to the correct device?

Alex

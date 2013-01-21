Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v9 08/11] PCI, ACPI: debug print for installation of acpi root bridge's notifier
Date: Mon, 21 Jan 2013 13:43:53 +0100
Message-ID: <2845150.CbZVjsYMRJ@vostro.rjw.lan>
In-Reply-To: <CAE9FiQXW7xkSEtxr7Wa4DQpEhdAsas7g=0bYkC+vUKp_7=Qj_A@mail.gmail.com>
References: <1358495602-22867-1-git-send-email-yinghai@kernel.org> <2506887.8XgRPLTxfQ@vostro.rjw.lan> <CAE9FiQXW7xkSEtxr7Wa4DQpEhdAsas7g=0bYkC+vUKp_7=Qj_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, January 20, 2013 06:37:59 PM Yinghai Lu wrote:
> On Sun, Jan 20, 2013 at 3:00 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, January 17, 2013 11:53:19 PM Yinghai Lu wrote:
> >> From: Tang Chen <tangchen@cn.fujitsu.com>
> >>
> >> acpi_install_notify_handler() could fail. So check the exit status
> >> and give a better debug info.
> >>
> >> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> ---
> >>  drivers/acpi/pci_root.c |   12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >> index 3ce5d80..f3ceb61 100644
> >> --- a/drivers/acpi/pci_root.c
> >> +++ b/drivers/acpi/pci_root.c
> >> @@ -762,6 +762,7 @@ static void handle_hotplug_event_root(acpi_handle handle, u32 type,
> >>  static acpi_status __init
> >>  find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
> >>  {
> >> +     acpi_status status;
> >>       char objname[64];
> >>       struct acpi_buffer buffer = { .length = sizeof(objname),
> >>                                     .pointer = objname };
> >> @@ -774,9 +775,14 @@ find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
> >>
> >>       acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> >>
> >> -     acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
> >> -                             handle_hotplug_event_root, NULL);
> >> -     printk(KERN_DEBUG "acpi root: %s notify handler installed\n", objname);
> >> +     status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
> >> +                                     handle_hotplug_event_root, NULL);
> >> +     if (ACPI_FAILURE(status))
> >> +             printk(KERN_DEBUG "acpi root: %s notify handler is not installed, exit status: %u\n",
> >
> > Can you break that line, please?  And use pr_debug()?
> 
> Long line should be ok, and checkpatch.pl is not complaining about that.
> 
> Also keep the complete print out in one line, could make git grep find
> that code exactly.
> 
> Actually I really hate pr_debug(), that will make the generated code
> different with DEBUG
> defined or not. And need to end user to recompile kernel to get debug
> output if needed.

OK, whatever.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
